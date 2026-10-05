//! Vault asset lookup + build-time image pipeline.
//!
//! Output names are derived from hash(source bytes + operation + PIPELINE_VERSION), so pages render
//! before anything is encoded. `finish()` then encodes every missing variant in parallel into the
//! cache dir and copies the set into `dist/a/`. An unchanged image costs one read + hash per build.
//!
//! Operations (diobsidian's pipeline, ported):
//! - AVIF at 1x/2x of the display size + a JPEG/PNG fallback for browsers without AVIF
//! - PNG icon masks
//! - Floyd–Steinberg dither to N grey levels (baked duotone, or greyscale tinted by CSS with `--accent`)
//! - ASCII art (dark and light-theme variants)

use anyhow::{anyhow, Context, Result};
use image::codecs::avif::AvifEncoder;
use image::codecs::jpeg::JpegEncoder;
use image::codecs::png::{CompressionType, FilterType as PngFilter, PngEncoder};
use image::imageops::FilterType;
use image::metadata::Orientation;
use image::{DynamicImage, ImageDecoder, ImageReader};
use rayon::prelude::*;
use std::collections::{BTreeMap, HashMap};
use std::fs;
use std::io::Cursor;
use std::path::{Path, PathBuf};
use std::time::Instant;

/// Bump to invalidate every cached variant (e.g. after changing encoder settings).
const PIPELINE_VERSION: &str = "p3.2";
/// Bump to regenerate ASCII art only.
const ASCII_VERSION: &str = "a2";
const AVIF_SPEED: u8 = 6;
const AVIF_QUALITY: u8 = 70;
/// 2x variants hide artifacts at twice the pixel density; spend fewer bytes on them.
const AVIF_QUALITY_2X: u8 = 56;
const JPEG_QUALITY: u8 = 80;
const DITHER_MAX_W: u32 = 600;
const ASCII_COLS: u32 = 120;
const ASCII_CHARS: [char; 8] = [' ', '·', '∘', ':', '░', '▒', '▓', '█'];

/// How an image is displayed; decides the 1x size.
#[derive(Clone, Copy)]
pub enum Fit {
    /// Fixed display height (gallery strips).
    Height(u32),
    /// Max display box (inline markdown images): fits inside w×h, keeping aspect.
    Within(u32, u32),
    /// Square crop (avatar).
    Cover(u32),
}

#[derive(Clone, Debug)]
enum Op {
    Avif { w: u32, h: u32, cover: bool, q: u8 },
    Jpeg { w: u32, h: u32, cover: bool },
    Png { w: u32, h: u32, cover: bool },
    Dither { w: u32, levels: u8, accent: bool },
}

#[derive(Clone, Copy)]
struct Source {
    hash: u64,
    w: u32,
    h: u32,
    alpha: bool,
}

pub struct Picture {
    pub w: u32,
    pub h: u32,
    /// Fallback `<img src>` (JPEG/PNG).
    pub src: String,
    /// AVIF candidates as (url, density).
    pub avif: Vec<(String, u32)>,
}

impl Picture {
    pub fn html(&self, alt: &str, attrs: &str) -> String {
        let img = format!(
            "<img src=\"{}\" width=\"{}\" height=\"{}\" alt=\"{}\"{attrs}>",
            self.src,
            self.w,
            self.h,
            crate::page::esc(alt)
        );
        if self.avif.is_empty() {
            return img;
        }
        let srcset: Vec<String> = self.avif.iter().map(|(u, d)| format!("{u} {d}x")).collect();
        format!("<picture><source type=\"image/avif\" srcset=\"{}\">{img}</picture>", srcset.join(", "))
    }

    /// Highest-density variant, for "open full size" links.
    pub fn largest(&self) -> &str {
        self.avif.last().map_or(&self.src, |(u, _)| u)
    }
}

pub struct Assets {
    /// lowercase file name -> source path (Obsidian resolves embeds by file name).
    index: HashMap<String, PathBuf>,
    out: PathBuf,
    cache: PathBuf,
    sources: HashMap<PathBuf, Source>,
    /// source -> output file name -> operation
    jobs: BTreeMap<PathBuf, BTreeMap<String, Op>>,
}

impl Assets {
    pub fn new(vault: &Path, out: &Path, cache: &Path) -> Result<Self> {
        let mut index = HashMap::new();
        for entry in walkdir::WalkDir::new(vault).into_iter().filter_map(Result::ok) {
            let path = entry.path();
            let name = entry.file_name().to_string_lossy().to_lowercase();
            if !entry.file_type().is_file() || name.ends_with(".md") || name.starts_with('.') {
                continue;
            }
            if let Some(prev) = index.insert(name.clone(), path.to_path_buf()) {
                eprintln!("warn: duplicate asset name {name}: {} vs {}", prev.display(), path.display());
            }
        }
        fs::create_dir_all(out.join("a"))?;
        fs::create_dir_all(cache.join("meta"))?;
        Ok(Self {
            index,
            out: out.to_path_buf(),
            cache: cache.to_path_buf(),
            sources: HashMap::new(),
            jobs: BTreeMap::new(),
        })
    }

    fn find(&self, name: &str) -> Result<PathBuf> {
        self.index
            .get(&name.trim().to_lowercase())
            .cloned()
            .ok_or_else(|| anyhow!("asset not found in vault: {name}"))
    }

    pub fn exists(&self, name: &str) -> bool {
        self.find(name).is_ok()
    }

    pub fn read_text(&self, name: &str) -> Result<String> {
        Ok(fs::read_to_string(self.find(name)?)?)
    }

    /// Orientation-corrected size and real transparency, cached per source hash
    /// (finding out needs a full decode, which we only want to pay once).
    fn source(&mut self, name: &str) -> Result<(PathBuf, Source)> {
        let path = self.find(name)?;
        if let Some(s) = self.sources.get(&path) {
            return Ok((path, *s));
        }
        let bytes = fs::read(&path).with_context(|| format!("reading {}", path.display()))?;
        let hash = fnv1a(&bytes);
        let meta = self.cache.join("meta").join(format!("{hash:016x}"));
        let parsed = fs::read_to_string(&meta).ok().and_then(|m| {
            let v: Vec<u32> = m.split_whitespace().filter_map(|x| x.parse().ok()).collect();
            (v.len() == 3).then(|| Source { hash, w: v[0], h: v[1], alpha: v[2] == 1 })
        });
        let s = match parsed {
            Some(s) => s,
            None => {
                let img = decode(&bytes).with_context(|| format!("decoding {}", path.display()))?;
                let alpha = img.color().has_alpha() && img.to_rgba8().pixels().any(|p| p[3] < 255);
                let s = Source { hash, w: img.width(), h: img.height(), alpha };
                fs::write(&meta, format!("{} {} {}", s.w, s.h, s.alpha as u8))?;
                s
            }
        };
        self.sources.insert(path.clone(), s);
        Ok((path, s))
    }

    fn variant(&mut self, src: &Path, s: Source, op: Op, ext: &str) -> String {
        let key = fnv1a(format!("{:x}{op:?}{PIPELINE_VERSION}", s.hash).as_bytes());
        let (w, h) = match op {
            Op::Avif { w, h, .. } | Op::Jpeg { w, h, .. } | Op::Png { w, h, .. } => (w, h),
            Op::Dither { w, .. } => (w, scale(s.h, w, s.w)),
        };
        let stem = sanitize(&src.file_stem().unwrap_or_default().to_string_lossy());
        let name = format!("{stem}.{:08x}.{w}x{h}.{ext}", key as u32);
        self.jobs.entry(src.to_path_buf()).or_default().insert(name.clone(), op);
        format!("/a/{name}")
    }

    pub fn picture(&mut self, name: &str, fit: Fit) -> Result<Picture> {
        let (src, s) = self.source(name)?;
        let cover = matches!(fit, Fit::Cover(_));
        let (w, h) = match fit {
            Fit::Height(fh) => {
                let h = fh.min(s.h);
                (scale(s.w, h, s.h), h)
            }
            Fit::Within(fw, fh) => {
                let w = fw.min(s.w);
                let h = scale(s.h, w, s.w);
                if h > fh { (scale(s.w, fh, s.h), fh) } else { (w, h) }
            }
            Fit::Cover(side) => {
                let side = side.min(s.w).min(s.h);
                (side, side)
            }
        };
        let mut avif = vec![(self.variant(&src, s, Op::Avif { w, h, cover, q: AVIF_QUALITY }, "avif"), 1)];
        let (w2, h2) = (w * 2, h * 2);
        let fits_2x = if cover { w2 <= s.w.min(s.h) } else { w2 <= s.w && h2 <= s.h };
        if fits_2x {
            avif.push((self.variant(&src, s, Op::Avif { w: w2, h: h2, cover, q: AVIF_QUALITY_2X }, "avif"), 2));
        }
        let fallback = if s.alpha {
            self.variant(&src, s, Op::Png { w, h, cover }, "png")
        } else {
            self.variant(&src, s, Op::Jpeg { w, h, cover }, "jpg")
        };
        Ok(Picture { w, h, src: fallback, avif })
    }

    /// Small PNG used as a CSS mask (recoloured icons), rendered at 2x of `size`.
    pub fn mask(&mut self, name: &str, size: u32) -> Result<String> {
        let (src, s) = self.source(name)?;
        let side = (size * 2) as f64;
        let k = (side / s.w.max(s.h) as f64).min(1.0);
        let (w, h) = (((s.w as f64 * k).round() as u32).max(1), ((s.h as f64 * k).round() as u32).max(1));
        Ok(self.variant(&src, s, Op::Png { w, h, cover: false }, "png"))
    }

    pub fn dither(&mut self, name: &str, levels: u8, accent: bool) -> Result<Picture> {
        let (src, s) = self.source(name)?;
        let w = s.w.min(DITHER_MAX_W);
        let url = self.variant(&src, s, Op::Dither { w, levels, accent }, "png");
        Ok(Picture { w, h: scale(s.h, w, s.w), src: url, avif: Vec::new() })
    }

    /// ASCII art for a raster image (dark-theme character mapping). Generated synchronously; cached.
    pub fn ascii(&mut self, name: &str) -> Result<String> {
        let (src, s) = self.source(name)?;
        let key = fnv1a(format!("{:x}ascii{ASCII_COLS}{ASCII_CHARS:?}{ASCII_VERSION}", s.hash).as_bytes());
        let path = self.cache.join(format!("{key:016x}.txt"));
        if let Ok(text) = fs::read_to_string(&path) {
            return Ok(text);
        }
        let img = decode(&fs::read(&src)?)?;
        let text = to_ascii(&img);
        fs::write(&path, &text)?;
        Ok(text)
    }

    /// Writes `a/<stem>.<hash>.<ext>` directly (non-image build outputs such as site.js).
    pub fn write_hashed(&self, stem: &str, ext: &str, bytes: &[u8]) -> Result<String> {
        let name = format!("{}.{:08x}.{ext}", sanitize(stem), fnv1a(bytes) as u32);
        fs::write(self.out.join("a").join(&name), bytes)?;
        Ok(format!("/a/{name}"))
    }

    /// Encodes missing variants (parallel, one decode per source) and copies all into `dist/a/`.
    pub fn finish(&self) -> Result<String> {
        let t0 = Instant::now();
        let encoded: Vec<usize> = self
            .jobs
            .par_iter()
            .map(|(src, ops)| -> Result<usize> {
                let missing: Vec<_> = ops.iter().filter(|(n, _)| !self.cache.join(n).exists()).collect();
                if missing.is_empty() {
                    return Ok(0);
                }
                let mut img = decode(&fs::read(src)?).with_context(|| format!("decoding {}", src.display()))?;
                if !self.sources[src].alpha && img.color().has_alpha() {
                    img = DynamicImage::ImageRgb8(img.to_rgb8());
                }
                for (name, op) in &missing {
                    let bytes = encode(&img, op).with_context(|| format!("encoding {name}"))?;
                    let tmp = self.cache.join(format!("{name}.tmp"));
                    fs::write(&tmp, bytes)?;
                    fs::rename(&tmp, self.cache.join(name))?;
                }
                Ok(missing.len())
            })
            .collect::<Result<_>>()?;

        let (mut files, mut bytes) = (0, 0u64);
        for name in self.jobs.values().flat_map(|ops| ops.keys()) {
            bytes += fs::copy(self.cache.join(name), self.out.join("a").join(name))?;
            files += 1;
        }
        let n: usize = encoded.iter().sum();
        Ok(format!(
            "{files} image files ({:.0} KB), {n} encoded, {} cached, in {:.1?}",
            bytes as f64 / 1024.0,
            files - n,
            t0.elapsed()
        ))
    }
}

fn decode(bytes: &[u8]) -> Result<DynamicImage> {
    let mut dec = ImageReader::new(Cursor::new(bytes)).with_guessed_format()?.into_decoder()?;
    let orientation = dec.orientation().unwrap_or(Orientation::NoTransforms);
    let mut img = DynamicImage::from_decoder(dec)?;
    img.apply_orientation(orientation);
    Ok(img)
}

fn resize(img: &DynamicImage, w: u32, h: u32, cover: bool) -> DynamicImage {
    if img.width() == w && img.height() == h {
        img.clone()
    } else if cover {
        img.resize_to_fill(w, h, FilterType::Lanczos3)
    } else {
        img.resize_exact(w, h, FilterType::Lanczos3)
    }
}

fn encode(img: &DynamicImage, op: &Op) -> Result<Vec<u8>> {
    let mut buf = Vec::new();
    match *op {
        Op::Avif { w, h, cover, q } => {
            resize(img, w, h, cover).write_with_encoder(AvifEncoder::new_with_speed_quality(&mut buf, AVIF_SPEED, q))?
        }
        Op::Jpeg { w, h, cover } => DynamicImage::ImageRgb8(resize(img, w, h, cover).to_rgb8())
            .write_with_encoder(JpegEncoder::new_with_quality(&mut buf, JPEG_QUALITY))?,
        Op::Png { w, h, cover } => resize(img, w, h, cover)
            .write_with_encoder(PngEncoder::new_with_quality(&mut buf, CompressionType::Best, PngFilter::Adaptive))?,
        Op::Dither { w, levels, accent } => {
            let (dw, dh, idx) = dither(img, w, levels);
            return indexed_png(dw, dh, &idx, dither_palette(levels, accent));
        }
    }
    Ok(buf)
}

/// Floyd–Steinberg error diffusion to `levels` evenly spaced grey levels; returns per-pixel level indices.
fn dither(img: &DynamicImage, max_w: u32, levels: u8) -> (u32, u32, Vec<u8>) {
    let img = if img.width() > max_w { img.resize(max_w, u32::MAX, FilterType::Lanczos3) } else { img.clone() };
    let grey = img.to_luma8();
    let (w, h) = (grey.width() as usize, grey.height() as usize);
    let mut px: Vec<f32> = grey.as_raw().iter().map(|&v| v as f32).collect();
    let mut idx = vec![0u8; w * h];
    let top = (levels.max(2) - 1) as f32;
    let step = 255.0 / top;
    for y in 0..h {
        for x in 0..w {
            let i = y * w + x;
            let level = (px[i] / step).round().clamp(0.0, top);
            idx[i] = level as u8;
            let err = px[i] - level * step;
            if x + 1 < w {
                px[i + 1] += err * 7.0 / 16.0;
            }
            if y + 1 < h {
                if x > 0 {
                    px[i + w - 1] += err * 3.0 / 16.0;
                }
                px[i + w] += err * 5.0 / 16.0;
                if x + 1 < w {
                    px[i + w + 1] += err / 16.0;
                }
            }
        }
    }
    (w as u32, h as u32, idx)
}

/// `accent`: grey ramp (tinted at runtime by CSS). Otherwise the baked navy→cream duotone.
fn dither_palette(levels: u8, accent: bool) -> Vec<u8> {
    let top = (levels.max(2) - 1) as f32;
    (0..levels.max(2))
        .flat_map(|i| {
            let t = i as f32 / top;
            if accent {
                let v = (t * 255.0).round() as u8;
                [v, v, v]
            } else {
                [(20.0 + t * 220.0) as u8, (22.0 + t * 213.0) as u8, (40.0 + t * 180.0) as u8]
            }
        })
        .collect()
}

/// Palette PNG at the smallest bit depth that holds the palette (4 levels -> 2 bits/pixel).
fn indexed_png(w: u32, h: u32, idx: &[u8], palette: Vec<u8>) -> Result<Vec<u8>> {
    let colours = palette.len() / 3;
    let (bits, depth) = match colours {
        0..=2 => (1, png::BitDepth::One),
        3..=4 => (2, png::BitDepth::Two),
        5..=16 => (4, png::BitDepth::Four),
        _ => (8, png::BitDepth::Eight),
    };
    let per_byte = 8 / bits;
    let row_bytes = (w as usize).div_ceil(per_byte);
    let mut packed = vec![0u8; row_bytes * h as usize];
    for (y, row) in idx.chunks(w as usize).enumerate() {
        for (x, &v) in row.iter().enumerate() {
            let shift = 8 - bits * (x % per_byte + 1);
            packed[y * row_bytes + x / per_byte] |= v << shift;
        }
    }
    let mut buf = Vec::new();
    let mut enc = png::Encoder::new(&mut buf, w, h);
    enc.set_color(png::ColorType::Indexed);
    enc.set_depth(depth);
    enc.set_palette(palette);
    enc.set_compression(png::Compression::High);
    let mut writer = enc.write_header()?;
    writer.write_image_data(&packed)?;
    writer.finish()?;
    Ok(buf)
}

/// Brighter pixel -> denser glyph (reads correctly on a dark background).
/// Rows use a 0.6 glyph aspect, matching the monospace advance assumed by the CSS.
fn to_ascii(img: &DynamicImage) -> String {
    let rows = ((img.height() as f64 / img.width() as f64) * ASCII_COLS as f64 * 0.6).round().max(1.0) as u32;
    let grey = img.resize_exact(ASCII_COLS, rows, FilterType::Triangle).to_luma8();
    // Contrast stretch (2nd–98th percentile) so the 8 glyphs span the subject, not a few mid-tones.
    let mut sorted = grey.as_raw().clone();
    sorted.sort_unstable();
    let lo = sorted[sorted.len() * 2 / 100] as f32;
    let hi = (sorted[sorted.len() * 98 / 100] as f32).max(lo + 1.0);
    let mut out = String::with_capacity(((ASCII_COLS + 1) * rows * 3) as usize);
    for y in 0..rows {
        for x in 0..ASCII_COLS {
            let t = ((grey.get_pixel(x, y)[0] as f32 - lo) / (hi - lo)).clamp(0.0, 0.999);
            out.push(ASCII_CHARS[(t * ASCII_CHARS.len() as f32) as usize]);
        }
        out.push('\n');
    }
    out
}

/// Light-theme variant: swap each glyph for its opposite density.
pub fn invert_ascii(text: &str) -> String {
    text.chars()
        .map(|c| match ASCII_CHARS.iter().position(|&a| a == c) {
            Some(i) => ASCII_CHARS[ASCII_CHARS.len() - 1 - i],
            None => c,
        })
        .collect()
}

fn scale(v: u32, num: u32, den: u32) -> u32 {
    ((v as u64 * num as u64 + den as u64 / 2) / den as u64).max(1) as u32
}

fn sanitize(s: &str) -> String {
    s.chars().map(|c| if c.is_ascii_alphanumeric() || c == '-' || c == '_' { c } else { '-' }).collect()
}

pub fn fnv1a(bytes: &[u8]) -> u64 {
    bytes.iter().fold(0xcbf29ce484222325, |h, b| (h ^ *b as u64).wrapping_mul(0x100000001b3))
}
