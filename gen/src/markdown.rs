//! Markdown -> HTML. Obsidian syntax is rewritten line-by-line (outside code fences) first:
//!
//! - `[[Project]]` / `[[Project|text]]` -> link to the project page (unknown targets become plain text)
//! - an image on its own line -> `<figure>`; consecutive image lines form a scrolling strip.
//!   Both `![[file.png|caption]]` and `![caption](path/file.png)` work, resolved by file name.
//!   Trailing flags: `--ascii`, `--dither [--4|--8|--16]`, `--accent`
//! - `![[art.txt]]` -> prebuilt ASCII art
//!
//! Then pulldown-cmark renders CommonMark + tables/strikethrough/task lists, with two event rewrites:
//! - code blocks: build-time highlighting + language label + copy button
//! - headings: levels used in the note are compressed to consecutive ranks starting at h2 (the page
//!   title is the h1), keeping the authored size via an `hN` class. Fixes skipped-level a11y errors.

use crate::assets::{invert_ascii, Assets, Fit};
use crate::page::esc;
use crate::vault::Site;
use crate::highlight::highlight;
use crate::page::{icon, CHECK, COPY};
use pulldown_cmark::{html, CodeBlockKind, Event, Options, Parser, Tag, TagEnd};
use std::collections::BTreeSet;

/// Inline image box: content column (900px project column minus padding) × a viewport-friendly height.
const INLINE_W: u32 = 880;
const INLINE_H: u32 = 720;
/// Display height of images inside a multi-image strip.
const STRIP_H: u32 = 320;

pub fn render(md: &str, site: &Site, assets: &mut Assets, ctx: &str) -> String {
    let pre = preprocess(md, site, assets, ctx);
    let mut out = String::with_capacity(pre.len() * 3 / 2);
    let opts = Options::ENABLE_TABLES | Options::ENABLE_STRIKETHROUGH | Options::ENABLE_TASKLISTS;
    let events: Vec<Event> = Parser::new_ext(&pre, opts).collect();

    let used: BTreeSet<usize> = events
        .iter()
        .filter_map(|e| match e {
            Event::Start(Tag::Heading { level, .. }) => Some(*level as usize),
            _ => None,
        })
        .collect();
    let rank = |level: usize| (2 + used.iter().position(|&l| l == level).unwrap_or(0)).min(6);

    let mut rewritten = Vec::with_capacity(events.len());
    let mut code: Option<(String, String)> = None;
    for e in events {
        match e {
            Event::Start(Tag::Heading { level, .. }) => {
                rewritten.push(Event::Html(format!("<h{} class=\"h{}\">", rank(level as usize), level as usize).into()))
            }
            Event::End(TagEnd::Heading(level)) => rewritten.push(Event::Html(format!("</h{}>", rank(level as usize)).into())),
            Event::Start(Tag::CodeBlock(kind)) => {
                let lang = match kind {
                    CodeBlockKind::Fenced(l) => l.split_whitespace().next().unwrap_or("").to_string(),
                    CodeBlockKind::Indented => String::new(),
                };
                code = Some((lang, String::new()));
            }
            Event::Text(t) if code.is_some() => code.as_mut().unwrap().1.push_str(&t),
            Event::End(TagEnd::CodeBlock) => {
                let (lang, src) = code.take().unwrap_or_default();
                rewritten.push(Event::Html(code_block(&lang, &src).into()));
            }
            other => rewritten.push(other),
        }
    }
    html::push_html(&mut out, rewritten.into_iter());
    out.replace("<a href=\"http", "<a target=\"_blank\" rel=\"noopener\" href=\"http")
}

#[derive(Default)]
struct Embed {
    name: String,
    caption: Option<String>,
    ascii: bool,
    dither: Option<u8>,
    accent: bool,
}

fn preprocess(md: &str, site: &Site, assets: &mut Assets, ctx: &str) -> String {
    let mut out = String::with_capacity(md.len());
    let mut fence: Option<&str> = None;
    let mut strip: Vec<Embed> = Vec::new();

    let flush = |strip: &mut Vec<Embed>, out: &mut String, assets: &mut Assets| {
        let rendered: Vec<String> = strip.iter().filter_map(|e| embed(e, strip.len() > 1, assets, ctx)).collect();
        strip.clear();
        match rendered.len() {
            0 => return,
            1 => out.push_str(&rendered[0]),
            _ => {
                out.push_str("<div class=\"strip\">");
                rendered.iter().for_each(|f| out.push_str(f));
                out.push_str("</div>");
            }
        }
        out.push_str("\n\n");
    };

    for line in md.lines() {
        let t = line.trim_start();
        if let Some(f) = fence {
            if t.starts_with(f) {
                fence = None;
            }
            out.push_str(line);
            out.push('\n');
            continue;
        }
        if t.starts_with("```") || t.starts_with("~~~") {
            flush(&mut strip, &mut out, assets);
            fence = Some(&t[..3]);
            out.push_str(line);
            out.push('\n');
            continue;
        }
        if let Some(e) = parse_embed(line.trim(), ctx) {
            strip.push(e);
            continue;
        }
        flush(&mut strip, &mut out, assets);
        out.push_str(&wikilinks(line, site, ctx));
        out.push('\n');
    }
    flush(&mut strip, &mut out, assets);
    out
}

/// A line holding exactly one image (wiki or standard syntax) plus optional flags.
fn parse_embed(line: &str, ctx: &str) -> Option<Embed> {
    let (mut e, rest) = if let Some(r) = line.strip_prefix("![[") {
        let end = r.find("]]")?;
        let (name, caption) = r[..end].split_once('|').map_or((&r[..end], None), |(n, c)| (n, Some(c)));
        (Embed { name: name.trim().into(), caption: caption.map(|c| c.trim().into()), ..Default::default() }, &r[end + 2..])
    } else if let Some(r) = line.strip_prefix("![") {
        let mid = r.find("](")?;
        let end = mid + r[mid..].find(')')?;
        let path = r[mid + 2..end].trim();
        if path.starts_with("http://") || path.starts_with("https://") {
            return None;
        }
        let name = path.rsplit('/').next().unwrap_or(path).replace("%20", " ");
        let alt = r[..mid].trim();
        (Embed { name, caption: (!alt.is_empty()).then(|| alt.into()), ..Default::default() }, &r[end + 1..])
    } else {
        return None;
    };
    for flag in rest.split_whitespace() {
        match flag.to_lowercase().as_str() {
            "--ascii" => e.ascii = true,
            "--dither" => e.dither = Some(e.dither.unwrap_or(4)),
            "--4" | "--8" | "--16" => e.dither = Some(flag[2..].parse().unwrap()),
            "--accent" => e.accent = true,
            other => {
                eprintln!("warn [{ctx}]: ignoring unknown image flag {other} on {}", e.name);
            }
        }
    }
    Some(e)
}

fn embed(e: &Embed, in_strip: bool, assets: &mut Assets, ctx: &str) -> Option<String> {
    if !assets.exists(&e.name) {
        eprintln!("warn [{ctx}]: missing embed {}", e.name);
        return None;
    }
    let alt = e.caption.as_deref().unwrap_or("");
    let cap = e.caption.as_ref().map(|c| format!("<figcaption>{}</figcaption>", esc(c))).unwrap_or_default();
    let result = if e.name.to_lowercase().ends_with(".txt") {
        assets.read_text(&e.name).map(|t| ascii_html(&t))
    } else if e.ascii {
        assets.ascii(&e.name).map(|t| ascii_html(&t))
    } else if let Some(levels) = e.dither {
        assets.dither(&e.name, levels, e.accent).map(|p| {
            let class = if e.accent { "dith acc" } else { "dith" };
            format!("<span class=\"{class}\">{}</span>", p.html(alt, " loading=\"lazy\" decoding=\"async\""))
        })
    } else {
        let fit = if in_strip { Fit::Height(STRIP_H) } else { Fit::Within(INLINE_W, INLINE_H) };
        assets.picture(&e.name, fit).map(|p| p.html(alt, " loading=\"lazy\" decoding=\"async\""))
    };
    match result {
        Ok(html) => Some(format!("<figure>{html}{cap}</figure>")),
        Err(err) => {
            eprintln!("warn [{ctx}]: {err:#}");
            None
        }
    }
}

fn code_block(lang: &str, src: &str) -> String {
    let label = if lang.is_empty() { "text" } else { lang };
    format!(
        "<div class=\"code\"><div class=\"code-h\"><span>{}</span><button class=\"copy\" type=\"button\" data-act=\"copy\" \
         aria-label=\"Copy code\">{}{}</button></div><pre><code>{}</code></pre></div>",
        esc(label),
        icon(COPY),
        icon(CHECK),
        highlight(src.trim_end_matches('\n'), lang)
    )
}

/// Dark and light variants; CSS shows the one matching the mode and scales the font so `--cols`
/// glyphs fill the container width.
fn ascii_html(text: &str) -> String {
    let text = text.trim_end_matches('\n');
    let cols = text.lines().map(|l| l.chars().count()).max().unwrap_or(1);
    format!(
        "<div class=\"ascii\" style=\"--cols:{cols}\" aria-hidden=\"true\"><pre class=\"asc-d\">{}</pre><pre class=\"asc-l\">{}</pre></div>",
        esc(text),
        esc(&invert_ascii(text))
    )
}

/// Rewrites `[[target]]` / `[[target|text]]` outside inline code spans.
fn wikilinks(line: &str, site: &Site, ctx: &str) -> String {
    if !line.contains("[[") {
        return line.to_string();
    }
    let mut out = String::with_capacity(line.len());
    let mut rest = line;
    let mut in_code = false;
    while !rest.is_empty() {
        if rest.starts_with('`') {
            in_code = !in_code;
            out.push('`');
            rest = &rest[1..];
            continue;
        }
        if !in_code && rest.starts_with("[[") {
            if let Some(end) = rest.find("]]") {
                let inner = &rest[2..end];
                let (target, text) = inner.split_once('|').unwrap_or((inner, inner));
                match site.project_by_title(target) {
                    Some(p) => out.push_str(&format!("[{}](/project/{}/)", text.trim(), p.slug)),
                    None => {
                        eprintln!("warn [{ctx}]: unresolved wikilink [[{inner}]]");
                        out.push_str(text.trim());
                    }
                }
                rest = &rest[end + 2..];
                continue;
            }
        }
        let c = rest.chars().next().unwrap();
        out.push(c);
        rest = &rest[c.len_utf8()..];
    }
    out
}
