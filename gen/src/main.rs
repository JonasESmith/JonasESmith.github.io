//! portfolio-gen: Obsidian vault -> prerendered static portfolio.
//!
//! gen build  [--vault vault] [--public public] [--out dist] [--cache .cache/img] [--drafts]
//! gen report [--out dist] [--save perf]

mod assets;
mod markdown;
mod page;
mod report;
mod theme;
mod vault;

use anyhow::{Context, Result};
use std::path::{Path, PathBuf};
use std::{fs, time::Instant};

fn main() -> Result<()> {
    let args: Vec<String> = std::env::args().skip(1).collect();
    let flag = |name: &str, default: &str| -> PathBuf {
        args.windows(2)
            .find(|w| w[0] == name)
            .map(|w| PathBuf::from(&w[1]))
            .unwrap_or_else(|| PathBuf::from(default))
    };
    let out = flag("--out", "dist");
    match args.first().map(String::as_str).unwrap_or("build") {
        "build" => build(
            &flag("--vault", "vault"),
            &flag("--public", "public"),
            &out,
            &flag("--cache", ".cache/img"),
            args.iter().any(|a| a == "--drafts"),
        ),
        "report" => report::run(&out, &flag("--save", "perf")),
        _ => {
            eprintln!("usage: gen [build|report] [--vault DIR] [--public DIR] [--out DIR] [--cache DIR] [--drafts]");
            std::process::exit(2)
        }
    }
}

fn build(vault_dir: &Path, public_dir: &Path, out: &Path, cache: &Path, drafts: bool) -> Result<()> {
    let t0 = Instant::now();
    let site = vault::load(vault_dir, drafts)?;
    let themes = theme::Themes::load()?;

    if out.exists() {
        fs::remove_dir_all(out).with_context(|| format!("clearing {}", out.display()))?;
    }
    fs::create_dir_all(out)?;
    copy_dir(public_dir, out)?;

    let mut assets = assets::Assets::new(vault_dir, out, cache)?;
    let pages = page::render_site(&site, &themes, &mut assets)?;
    for (rel, html) in &pages {
        let path = out.join(rel);
        fs::create_dir_all(path.parent().unwrap())?;
        fs::write(&path, html)?;
    }

    let images = assets.finish()?;
    eprintln!("built {} pages -> {} in {:.1?}; {images}", pages.len(), out.display(), t0.elapsed());
    Ok(())
}

/// Passthrough files (privacy notice, favicon, CNAME…) are copied byte-for-byte.
fn copy_dir(from: &Path, to: &Path) -> Result<()> {
    if !from.exists() {
        return Ok(());
    }
    for entry in walkdir::WalkDir::new(from).into_iter().filter_map(Result::ok) {
        let rel = entry.path().strip_prefix(from)?;
        let dest = to.join(rel);
        if entry.file_type().is_dir() {
            fs::create_dir_all(&dest)?;
        } else if !rel.to_string_lossy().ends_with(".DS_Store") {
            fs::copy(entry.path(), &dest)?;
        }
    }
    Ok(())
}
