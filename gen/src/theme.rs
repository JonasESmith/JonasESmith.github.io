//! Colour schemes -> CSS custom properties.
//!
//! Each scheme provides primary/secondary/tertiary for light and dark. Everything else is derived with
//! constants fitted to pixels sampled from the live Flutter site (Midnight, 2026-10-05; see CONTEXT.md):
//!   scaffold #141516 / #fcfcfd, divider #383a3c / #d2d4d7, footer bar #161717 / #fbfbfc,
//!   footer buttons (secondaryHeaderColor) #465262 / #ccd4e1.

use anyhow::{Context, Result};
use serde::Deserialize;
use std::fmt::Write;

#[derive(Deserialize)]
pub struct Scheme {
    pub id: String,
    pub name: String,
    pub light: [String; 3],
    pub dark: [String; 3],
}

#[derive(Deserialize)]
pub struct Themes {
    pub scheme: Vec<Scheme>,
}

#[derive(Clone, Copy)]
struct Rgb(f64, f64, f64);

impl Rgb {
    fn parse(hex: &str) -> Result<Self> {
        let v = u32::from_str_radix(hex.trim_start_matches('#'), 16).with_context(|| format!("bad colour {hex}"))?;
        Ok(Rgb((v >> 16 & 255) as f64, (v >> 8 & 255) as f64, (v & 255) as f64))
    }
    fn mix(self, o: Rgb, t: f64) -> Rgb {
        Rgb(self.0 + (o.0 - self.0) * t, self.1 + (o.1 - self.1) * t, self.2 + (o.2 - self.2) * t)
    }
    fn luminance(self) -> f64 {
        let ch = |c: f64| {
            let c = c / 255.0;
            if c <= 0.03928 { c / 12.92 } else { ((c + 0.055) / 1.055).powf(2.4) }
        };
        0.2126 * ch(self.0) + 0.7152 * ch(self.1) + 0.0722 * ch(self.2)
    }
    fn contrast(self, o: Rgb) -> f64 {
        let (a, b) = (self.luminance(), o.luminance());
        (a.max(b) + 0.05) / (a.min(b) + 0.05)
    }
    /// Smallest step toward `toward` that reaches WCAG AA (4.5:1, with margin) against every bg.
    fn legible_on(self, bgs: &[Rgb], toward: Rgb) -> Rgb {
        (0..=50)
            .map(|i| self.mix(toward, i as f64 * 0.02))
            .find(|c| bgs.iter().all(|bg| c.contrast(*bg) >= 4.6))
            .unwrap_or(toward)
    }
    fn hex(self) -> String {
        format!("#{:02x}{:02x}{:02x}", self.0.round() as u8, self.1.round() as u8, self.2.round() as u8)
    }
}

impl Themes {
    pub fn load() -> Result<Self> {
        let t: Themes = toml::from_str(include_str!("../themes.toml")).context("themes.toml")?;
        anyhow::ensure!(!t.scheme.is_empty(), "themes.toml has no schemes");
        Ok(t)
    }

    /// Per-scheme variables, plus scheme-dependent UI selectors (current name, selected row).
    pub fn css(&self) -> Result<String> {
        let mut css = String::new();
        for (i, s) in self.scheme.iter().enumerate() {
            let light = vars(&s.light, false)?;
            let dark = vars(&s.dark, true)?;
            let id = &s.id;
            write!(css, "[data-scheme={id}]{{{light}}}[data-scheme={id}][data-mode=dark]{{{dark}}}")?;
            if i == 0 {
                // No JS / before init: follow the OS.
                write!(css, "@media(prefers-color-scheme:dark){{:root:not([data-mode]){{{dark}}}}}")?;
            }
            write!(css, "[data-scheme={id}] .sn-{id}{{display:inline}}[data-scheme={id}] .sc[data-id={id}]{{border-color:var(--p)}}")?;
        }
        Ok(css)
    }
}

fn vars(c: &[String; 3], dark: bool) -> Result<String> {
    let [p, s, t] = [Rgb::parse(&c[0])?, Rgb::parse(&c[1])?, Rgb::parse(&c[2])?];
    let (base, on) = if dark {
        (Rgb(18.0, 18.0, 18.0), Rgb(230.0, 225.0, 229.0))
    } else {
        (Rgb(255.0, 255.0, 255.0), Rgb(28.0, 27.0, 31.0))
    };
    let bg = base.mix(p, 0.014);
    // Card/surface: near-neutral; the footer bar is this at 30% over the scaffold.
    let card = if dark { Rgb(27.0, 27.0, 27.0).mix(p, 0.02) } else { Rgb(250.0, 250.0, 250.0).mix(p, 0.012) };
    // Footer buttons (Flutter `secondaryHeaderColor`): a primary-tinted chip.
    let hdr = if dark { base.mix(p, 0.34) } else { base.mix(p, 0.2) };
    let black = Rgb(0.0, 0.0, 0.0);
    let white = Rgb(255.0, 255.0, 255.0);
    // Text on primary: whichever of black/white contrasts more. Icon tint keeps Flutter's literal 0.5 rule.
    let on_p = if p.luminance() > 0.179 { black } else { white };
    let p_light = p.luminance() > 0.5;
    // Footer bar: card @ 30% over the scaffold, flattened so content scrolling underneath can't show through.
    // (Opaque on purpose: the bar is sticky over content.)
    let bar = bg.mix(card, 0.3);
    // Text-safe variants: Flutter used iOS #007AFF / #AF52DE links and raw primary for link-ish text,
    // which fail AA on several surfaces. Nudge toward black (light) / white (dark) only as far as needed.
    let card_on_bg = bg.mix(p, 0.05);
    let toward = if dark { white } else { black };
    let surfaces = [bg, card_on_bg, card];
    let link = Rgb(0.0, 122.0, 255.0).legible_on(&surfaces, toward);
    let link_v = Rgb(175.0, 82.0, 222.0).legible_on(&surfaces, toward);
    let p_text = p.legible_on(&[bg, bg.mix(p, 0.1)], toward);
    Ok(format!(
        "--p:{};--s:{};--t:{};--bg:{};--card:{};--bar:{};--hdr:{};--fg:{};--div:{};--dis:{};--muted:{};--on-p:{};--icon-fg:{};\
         --link:{};--link-v:{};--p-text:{}",
        p.hex(),
        s.hex(),
        t.hex(),
        bg.hex(),
        card.hex(),
        bar.hex(),
        hdr.hex(),
        on.hex(),
        bg.mix(on, 0.185).hex(),
        bg.mix(on, 0.38).hex(),
        bg.mix(on, 0.72).hex(),
        on_p.hex(),
        if p_light { "rgba(0,0,0,.87)" } else { "rgba(255,255,255,.7)" },
        link.hex(),
        link_v.hex(),
        p_text.hex(),
    ))
}

/// Swatch dots for the picker: light and dark P/S/T as inline custom properties.
pub fn swatch_style(s: &Scheme) -> String {
    format!(
        "--a:{};--b:{};--c:{};--ad:{};--bd:{};--cd:{}",
        s.light[0], s.light[1], s.light[2], s.dark[0], s.dark[1], s.dark[2]
    )
}
