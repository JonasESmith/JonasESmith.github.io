//! `gen report`: per-page transfer budget from the built `dist/`.
//!
//! For each HTML page: document size (raw / gzip / brotli) and every same-origin subresource it
//! references, split into first-view (eager) and lazy. Written to stdout and `perf/<date>-<rev>.md`.

use anyhow::{Context, Result};
use std::collections::BTreeSet;
use std::fs;
use std::io::Write as _;
use std::path::Path;
use std::process::Command;

/// Budgets from CONTEXT.md §1.
const HTML_BR_BUDGET: usize = 14 * 1024;
const JS_BR_BUDGET: usize = 10 * 1024;

struct Sizes {
    raw: usize,
    gz: usize,
    br: usize,
}

fn sizes(bytes: &[u8]) -> Result<Sizes> {
    let mut gz = flate2::write::GzEncoder::new(Vec::new(), flate2::Compression::best());
    gz.write_all(bytes)?;
    let gz = gz.finish()?.len();
    let mut br = Vec::new();
    brotli::BrotliCompress(&mut &bytes[..], &mut br, &brotli::enc::BrotliEncoderParams { quality: 11, ..Default::default() })?;
    Ok(Sizes { raw: bytes.len(), gz, br: br.len() })
}

/// Text assets (html/js/css/svg/txt) are served compressed; images are not.
fn wire(path: &Path, bytes: &[u8]) -> Result<usize> {
    let ext = path.extension().and_then(|e| e.to_str()).unwrap_or("");
    Ok(if matches!(ext, "html" | "js" | "css" | "svg" | "txt" | "json") { sizes(bytes)?.gz } else { bytes.len() })
}

/// `check`: fail (non-zero exit) when any budget is exceeded, for CI.
pub fn run(out: &Path, save_dir: &Path, check: bool) -> Result<()> {
    anyhow::ensure!(out.is_dir(), "{} not built — run `gen build` first", out.display());
    let rev = git(&["rev-parse", "--short", "HEAD"]).unwrap_or_else(|| "nogit".into());
    let dirty = git(&["status", "--porcelain"]).is_some_and(|s| !s.is_empty());
    let rev = if dirty { format!("{rev}-dirty") } else { rev };
    let date = chrono::Local::now().format("%Y-%m-%d").to_string();

    let mut pages: Vec<_> = walkdir::WalkDir::new(out)
        .into_iter()
        .filter_map(Result::ok)
        .filter(|e| e.path().extension().is_some_and(|x| x == "html"))
        .map(|e| e.into_path())
        .collect();
    pages.sort();

    let mut md = format!(
        "# Perf report {date} ({rev})\n\nWire sizes: text assets gzip -9 (what GitHub Pages serves), images as-is; `<picture>` counts its largest AVIF candidate.\n\
         Budgets: HTML ≤ {}KB brotli, JS ≤ {}KB brotli.\n\n\
         | Page | HTML raw | HTML gz | HTML br | Blocking | First-view total | Lazy | Requests (eager) |\n|---|---|---|---|---|---|---|---|\n",
        HTML_BR_BUDGET / 1024,
        JS_BR_BUDGET / 1024
    );
    let mut over = Vec::new();
    for page in &pages {
        let html = fs::read_to_string(page)?;
        let doc = sizes(html.as_bytes())?;
        if doc.br > HTML_BR_BUDGET {
            over.push(format!("{}: HTML {}B br", rel(out, page), doc.br));
        }
        let (eager, lazy) = refs(&html);
        let mut first = doc.gz;
        let mut blocking = 0;
        for r in &eager {
            let p = out.join(r.trim_start_matches('/'));
            let bytes = fs::read(&p).with_context(|| format!("{} references missing {r}", rel(out, page)))?;
            first += wire(&p, &bytes)?;
            if r.ends_with(".css") {
                blocking += 1;
            }
            if r.ends_with(".js") {
                let s = sizes(&bytes)?;
                if s.br > JS_BR_BUDGET {
                    over.push(format!("{r}: JS {}B br", s.br));
                }
            }
        }
        let lazy_bytes: usize = lazy.iter().filter_map(|r| fs::read(out.join(r.trim_start_matches('/'))).ok()).map(|b| b.len()).sum();
        md += &format!(
            "| `{}` | {} | {} | {} | {} | {} | {} | {} |\n",
            rel(out, page),
            kb(doc.raw),
            kb(doc.gz),
            kb(doc.br),
            blocking,
            kb(first),
            kb(lazy_bytes),
            eager.len() + 1
        );
    }

    md += "\n## Largest files\n\n| File | Size |\n|---|---|\n";
    let mut files: Vec<_> = walkdir::WalkDir::new(out)
        .into_iter()
        .filter_map(Result::ok)
        .filter(|e| e.file_type().is_file())
        .map(|e| (e.metadata().map(|m| m.len()).unwrap_or(0), e.into_path()))
        .collect();
    files.sort_by(|a, b| b.0.cmp(&a.0));
    for (size, p) in files.iter().take(10) {
        md += &format!("| `{}` | {} |\n", rel(out, p), kb(*size as usize));
    }
    let total: u64 = files.iter().map(|f| f.0).sum();
    md += &format!("\nTotal dist: {} in {} files.\n", kb(total as usize), files.len());

    md += "\n## Budget\n\n";
    if over.is_empty() {
        md += "All pages within budget.\n";
    } else {
        over.iter().for_each(|o| md += &format!("- OVER: {o}\n"));
    }

    print!("{md}");
    if !check {
        fs::create_dir_all(save_dir)?;
        let file = save_dir.join(format!("{date}-{rev}.md"));
        fs::write(&file, &md)?;
        eprintln!("saved {}", file.display());
    }
    anyhow::ensure!(!check || over.is_empty(), "{} budget violation(s)", over.len());
    Ok(())
}

/// Same-origin subresources: (eager, lazy). Page links (`href` to `/…/` or `.html`) are skipped.
fn refs(html: &str) -> (BTreeSet<String>, BTreeSet<String>) {
    let (mut eager, mut lazy) = (BTreeSet::new(), BTreeSet::new());
    // <picture>: AVIF-capable browsers (~all) fetch one srcset candidate, not the <img> fallback.
    // Count the highest-density candidate (phones are 2x+). Then drop the segment from further scanning.
    let mut rest = String::with_capacity(html.len());
    let mut s = html;
    while let Some(start) = s.find("<picture>") {
        rest.push_str(&s[..start]);
        let end = s[start..].find("</picture>").map_or(s.len(), |e| start + e + 10);
        let seg = &s[start..end];
        if let Some(i) = seg.find("srcset=\"") {
            let set = &seg[i + 8..];
            let set = &set[..set.find('"').unwrap_or(0)];
            if let Some(url) = set.split(", ").last().and_then(|c| c.split(' ').next()) {
                if seg.contains("loading=\"lazy\"") { &mut lazy } else { &mut eager }.insert(url.to_string());
            }
        }
        s = &s[end..];
    }
    rest.push_str(s);
    let html = rest.as_str();
    for (i, _) in html.match_indices("src=\"/") {
        let url = &html[i + 5..];
        let url = &url[..url.find('"').unwrap_or(0)];
        let tag_end = html[i..].find('>').map_or(html.len(), |e| i + e);
        let is_lazy = html[i..tag_end].contains("loading=\"lazy\"");
        if is_lazy { &mut lazy } else { &mut eager }.insert(url.to_string());
    }
    for (i, _) in html.match_indices("url(/") {
        let url = &html[i + 4..];
        eager.insert(url[..url.find(')').unwrap_or(0)].to_string());
    }
    for (i, _) in html.match_indices("<link rel=\"stylesheet\" href=\"/") {
        let url = &html[i + 29..];
        eager.insert(url[..url.find('"').unwrap_or(0)].to_string());
    }
    eager.retain(|u| !u.is_empty());
    lazy.retain(|u| !u.is_empty() && !eager.contains(u));
    (eager, lazy)
}

fn rel(out: &Path, p: &Path) -> String {
    p.strip_prefix(out).unwrap_or(p).display().to_string()
}

fn kb(b: usize) -> String {
    if b < 1024 { format!("{b} B") } else { format!("{:.1} KB", b as f64 / 1024.0) }
}

fn git(args: &[&str]) -> Option<String> {
    let o = Command::new("git").args(args).output().ok()?;
    o.status.success().then(|| String::from_utf8_lossy(&o.stdout).trim().to_string())
}
