//! HTML templates. Every page is complete on its own: critical CSS + theme bootstrap inline,
//! one deferred, content-hashed `site.js` for interactivity.

use crate::assets::{Assets, Fit};
use crate::markdown;
use crate::theme::{swatch_style, Themes};
use crate::vault::{Project, Site, Skill};
use chrono::Datelike;
use anyhow::{Context, Result};
use chrono::{NaiveDate, Utc};
use std::fmt::Write;

/// Gallery strip height (Flutter: 600px ListView).
const GALLERY_H: u32 = 600;

const CSS: &str = include_str!("../static/site.css");
const SITE_JS: &str = include_str!("../static/site.js");
const INIT_JS: &str = include_str!("../static/init.js");

/// Shared chrome for every page.
struct Chrome {
    head: String,
    footer: String,
}

pub fn render_site(site: &Site, themes: &Themes, assets: &mut Assets) -> Result<Vec<(String, String)>> {
    let chrome = chrome(site, themes, assets)?;
    let mut pages = vec![("index.html".to_string(), home(site, assets, &chrome)?)];
    for p in &site.projects {
        let html = project(p, site, assets, &chrome).with_context(|| format!("project {}", p.title))?;
        pages.push((format!("project/{}/index.html", p.slug), html));
    }
    for s in &site.skills {
        let html = skill(s, site, assets, &chrome).with_context(|| format!("skill {}", s.name))?;
        pages.push((format!("skill/{}/index.html", s.slug), html));
    }
    pages.push(("404.html".to_string(), not_found(&chrome)));
    Ok(pages)
}

fn chrome(site: &Site, themes: &Themes, assets: &mut Assets) -> Result<Chrome> {
    let ids: Vec<&str> = themes.scheme.iter().map(|s| s.id.as_str()).collect();
    let init = INIT_JS.trim().replace("__SCHEMES__", &ids.join("|"));
    let js_url = assets.write_hashed("site", "js", SITE_JS.trim().as_bytes())?;
    let css = minify_css(&format!("{CSS}{}", themes.css()?));
    let head = format!(
        "<meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">\
         <link rel=\"icon\" href=\"/favicon.png\"><script>{init}</script><style>{css}</style>\
         <script src=\"{js_url}\" defer></script>"
    );

    let mut f = String::new();
    f.push_str("<footer class=\"bar\"><div class=\"bar-l\">");
    write!(
        f,
        "<button class=\"bb bb-p\" data-act=\"mode\" type=\"button\">\
         <span class=\"m-d\">Dark{}</span><span class=\"m-l\">Light{}</span></button>",
        icon(MOON),
        icon(SUN)
    )?;
    f.push_str("<button class=\"bb\" popovertarget=\"schemes\" type=\"button\" title=\"Command+P\">");
    for s in &themes.scheme {
        write!(f, "<span class=\"sn sn-{}\">{}</span>", s.id, esc(&s.name))?;
    }
    write!(f, "{}</button>", icon(CHEVRON_UP_SQUARE))?;
    write!(
        f,
        "<button class=\"bb\" data-act=\"follower\" type=\"button\">Mouse Shadow\
         <span class=\"f-on\">{}</span><span class=\"f-off\">{}</span></button>",
        icon(CURSOR),
        icon(CURSOR_OFF)
    )?;
    f.push_str("</div><nav class=\"bar-r\">");
    for link in &site.profile.links {
        let host = link.trim_start_matches("https://").trim_start_matches("http://").trim_start_matches("www.");
        let host = host.split('/').next().unwrap_or(host);
        write!(f, "<a class=\"bb\" href=\"{}\" target=\"_blank\" rel=\"noopener\">{}</a>", esc(link), esc(host))?;
    }
    write!(
        f,
        "<a class=\"bb email\" href=\"mailto:{}?subject=Hello&amp;body=I%20would%20love%20to%20speak%20soon!\">email</a>",
        esc(&site.profile.email)
    )?;
    write!(
        f,
        "</nav></footer><div id=\"schemes\" popover aria-label=\"Colour scheme\"><div class=\"pal-h\">\
         <input id=\"pal-q\" type=\"search\" placeholder=\"Search themes\" aria-label=\"Search themes\" autocomplete=\"off\">\
         <button class=\"pal-b\" data-act=\"prev\" type=\"button\" aria-label=\"Previous scheme\">{}</button>\
         <button class=\"pal-b\" data-act=\"next\" type=\"button\" aria-label=\"Next scheme\">{}</button>\
         <button class=\"pal-b\" data-act=\"mode\" type=\"button\" aria-label=\"Toggle light or dark\">\
         <span class=\"m-d\">{}</span><span class=\"m-l\">{}</span></button></div><div class=\"pal\">",
        icon(CHEVRON_UP),
        icon(CHEVRON_DOWN),
        icon(MOON),
        icon(SUN)
    )?;
    for s in &themes.scheme {
        write!(
            f,
            "<button class=\"sc\" data-act=\"scheme\" data-id=\"{}\" type=\"button\">\
             <span class=\"dots\" style=\"{}\"><i></i><i></i><i></i></span>{}</button>",
            s.id,
            swatch_style(s),
            esc(&s.name)
        )?;
    }
    f.push_str("</div></div>");
    Ok(Chrome { head, footer: f })
}

fn shell(chrome: &Chrome, title: &str, desc: &str, main: &str) -> String {
    let gutter = "~\n".repeat(60);
    format!(
        "<!doctype html><html lang=\"en\" data-scheme=\"midnight\"><head><title>{}</title>\
         <meta name=\"description\" content=\"{}\">{}</head><body>\
         <div class=\"glow\" aria-hidden=\"true\"><i class=\"g1\"><i></i><b class=\"gr\"><b></b></b></i><i class=\"g2\"><i></i></i></div>\
         <div class=\"app\"><pre class=\"gutter\" aria-hidden=\"true\">{gutter}</pre><main>{main}</main></div>{}</body></html>",
        esc(title),
        esc(desc),
        chrome.head,
        chrome.footer
    )
}

fn home(site: &Site, assets: &mut Assets, chrome: &Chrome) -> Result<String> {
    let pr = &site.profile;
    let today = Utc::now().date_naive();
    let days = (today - pr.birth_date).num_days();
    let avatar = assets.picture(&pr.avatar, Fit::Cover(40))?.html("", " class=\"avatar\"");
    let about = markdown::render(&pr.body, site, assets, "profile");

    let mut m = String::from("<div class=\"col col-home\">");
    write!(
        m,
        "<details class=\"card a1\"><summary>\
         {avatar}<b class=\"handle\">{}</b><b class=\"ver\" data-birth=\"{}\">v{}.{}</b>\
         <span class=\"chev\">{}</span></summary><hr><div class=\"md\">{about}</div></details>",
        esc(&pr.handle),
        pr.birth_date,
        days / 365,
        days % 365,
        icon(CHEVRON_DOWN)
    )?;

    write!(m, "<section class=\"a2\">{}<ul class=\"links\">", section_head("Notable Projects", KEYBOARD_CHEVRON))?;
    for p in &site.projects {
        // No icon: the tile shows the title's first letter instead.
        let (ico, letter) = match &p.icon {
            Some(name) => (format!(" style=\"--i:url({})\"", assets.mask(name, 16)?), String::new()),
            None => (" data-letter".to_string(), esc(&p.title.chars().next().unwrap_or('?').to_string())),
        };
        write!(
            m,
            "<li><a class=\"lsb\" href=\"/project/{}/\"><span class=\"lbl\">{}</span><span class=\"ico\"{ico}>{letter}</span></a></li>",
            p.slug,
            esc(&p.title)
        )?;
    }
    m.push_str("</ul></section>");

    write!(m, "<section class=\"a3\">{}<ul class=\"links\">", section_head("Skills", CHART_BAR))?;
    for s in &site.skills {
        let (attr, label) = skill_years(s, today);
        write!(
            m,
            "<li><a class=\"lsb\" href=\"/skill/{}/\"><span class=\"lbl\">{}</span><span class=\"yrs\"{attr}>{label} y</span></a></li>",
            s.slug,
            esc(&s.name)
        )?;
    }
    m.push_str("</ul></section></div>");

    Ok(shell(chrome, &pr.name, &format!("{} — projects and skills.", pr.name), &m))
}

/// Mirrors the Flutter site: ongoing skills show fractional years (refreshed client-side),
/// finished ones show the whole duration.
fn skill_years(s: &Skill, today: NaiveDate) -> (String, String) {
    match s.end {
        None => {
            let years = (today - s.start).num_days() as f64 / 365.25;
            (format!(" data-since=\"{}\"", s.start), format!("{years:.1}"))
        }
        Some(end) => {
            let days = (end - s.start).num_days();
            let (y, mo) = (days / 365, (days % 365) / 30);
            let label = match (y, mo) {
                (y, 0) if y > 0 => format!("{y}"),
                (y, mo) if y > 0 => format!("{y} year{}, {mo} month{}", plural(y), plural(mo)),
                (_, mo) if mo > 0 => format!("{mo} month{}", plural(mo)),
                _ => "Less than a month".into(),
            };
            (String::new(), label)
        }
    }
}

fn plural(n: i64) -> &'static str {
    if n > 1 { "s" } else { "" }
}

fn section_head(label: &str, svg: &str) -> String {
    format!("<h2 class=\"sec\"><span>{label}</span><hr>{}</h2>", icon(svg))
}

fn project(p: &Project, site: &Site, assets: &mut Assets, chrome: &Chrome) -> Result<String> {
    let mut m = String::from("<div class=\"col col-proj\"><div class=\"phead\"><div class=\"pill\">");
    write!(m, "<a class=\"pill-back\" href=\"/\" aria-label=\"Back\">{}</a>", icon(CHEVRON_BACK))?;
    match &p.url {
        Some(url) => write!(
            m,
            "<a class=\"pill-title\" href=\"{}\" target=\"_blank\" rel=\"noopener\"><h1>{}</h1>{}</a>",
            esc(url),
            esc(&p.title),
            icon(LINK)
        )?,
        None => write!(m, "<span class=\"pill-title\"><h1>{}</h1></span>", esc(&p.title))?,
    }
    m.push_str("</div><div class=\"plat\">");
    for plat in &p.platforms {
        let (svg, label) = match plat.as_str() {
            "ios" => (APPLE, "iOS"),
            "android" => (ANDROID, "Android"),
            "web" => (GLOBE, "Web"),
            "ipad" => (TABLET, "iPad"),
            "macos" => (DESKTOP, "macOS"),
            other => {
                eprintln!("warn [{}]: unknown platform {other}", p.title);
                continue;
            }
        };
        write!(m, "<span title=\"{label}\" role=\"img\" aria-label=\"{label}\">{}</span>", icon(svg))?;
    }
    m.push_str("</div></div>");

    if !p.technologies.is_empty() {
        m.push_str("<div class=\"tech b1\"><div class=\"lbl-s\">Technologies</div><div class=\"chips\">");
        for t in &p.technologies {
            let name: String = t.name.chars().take(20).collect();
            match &t.url {
                Some(url) => write!(
                    m,
                    "<a class=\"chip\" href=\"{}\" target=\"_blank\" rel=\"noopener\">{}{}</a>",
                    esc(url),
                    esc(&name),
                    icon(LINK)
                )?,
                None => write!(m, "<span class=\"chip\">{}</span>", esc(&name))?,
            }
        }
        m.push_str("</div></div>");
    }

    if !p.gallery.is_empty() {
        m.push_str("<div class=\"gallery b2\">");
        for (i, name) in p.gallery.iter().enumerate() {
            let pic = assets.picture(name, Fit::Height(GALLERY_H))?;
            // The first screenshot is the LCP element; the next is usually in view too. The rest load lazily.
            let attrs = match i {
                0 => " fetchpriority=\"high\"",
                1 => "",
                _ => " loading=\"lazy\" decoding=\"async\"",
            };
            let alt = format!("{} screenshot {}", p.title, i + 1);
            write!(m, "<a href=\"{}\" data-gallery>{}</a>", pic.largest(), pic.html(&alt, attrs))?;
        }
        m.push_str("</div>");
    }

    let body = markdown::render(&p.body, site, assets, &p.title);
    write!(m, "<hr class=\"pdiv\"><article class=\"md b3\">{body}</article></div>")?;
    if !p.gallery.is_empty() {
        // Lightbox shell; site.js fills it from the gallery links.
        write!(
            m,
            "<dialog id=\"lb\" aria-label=\"{0} screenshots\"><div class=\"lb-bar\">\
             <button class=\"lb-pill\" data-act=\"lb-close\" type=\"button\">{1}{0}</button>\
             <div class=\"lb-pill lb-pager\"><button data-act=\"lb-prev\" type=\"button\" aria-label=\"Previous image\">{1}</button>\
             <span class=\"lb-n\"></span><button data-act=\"lb-next\" type=\"button\" aria-label=\"Next image\">{2}</button></div></div>\
             <img class=\"lb-img\" alt=\"\"></dialog>",
            esc(&p.title),
            icon(CHEVRON_BACK),
            icon(CHEVRON_FWD)
        )?;
    }

    let desc = p.description.clone().unwrap_or_else(|| p.title.clone());
    Ok(shell(chrome, &format!("{} · {}", p.title, site.profile.name), &desc, &m))
}

/// Skill page: same header pill as projects, a span line ("since 2018 · 8.7 y"), the sub-skills
/// with their notes, then the note body (galleries, ASCII, dithering all work as in projects).
fn skill(s: &Skill, site: &Site, assets: &mut Assets, chrome: &Chrome) -> Result<String> {
    let today = Utc::now().date_naive();
    let (attr, label) = skill_years(s, today);
    let span = match s.end {
        Some(end) => format!("{}–{}", s.start.year(), end.year()),
        None => format!("since {}", s.start.year()),
    };
    let mut m = String::from("<div class=\"col col-proj\"><div class=\"phead\"><div class=\"pill\">");
    write!(
        m,
        "<a class=\"pill-back\" href=\"/\" aria-label=\"Back\">{}</a><span class=\"pill-title\"><h1>{}</h1></span></div>\
         <div class=\"span\">{span} · <span{attr}>{label} y</span></div></div>",
        icon(CHEVRON_BACK),
        esc(&s.name)
    )?;
    if !s.sub_skills.is_empty() {
        m.push_str("<div class=\"tech b1\"><div class=\"lbl-s\">Toolbox</div><ul class=\"subs\">");
        for sub in &s.sub_skills {
            match sub.note() {
                // tabindex: tap (touch) or keyboard focus reveals the note, like hover does
                Some(note) => write!(
                    m,
                    "<li><span class=\"chip\" tabindex=\"0\">{}</span><span class=\"sub-note\">{}</span>",
                    esc(sub.name()),
                    esc(note)
                )?,
                None => write!(m, "<li><span class=\"chip\">{}</span>", esc(sub.name()))?,
            }
            m.push_str("</li>");
        }
        m.push_str("</ul></div>");
    }
    let body = markdown::render(&s.body, site, assets, &s.name);
    write!(m, "<hr class=\"pdiv\"><article class=\"md b3\">{body}</article></div>")?;
    let desc = format!("{} — {span}.", s.name);
    Ok(shell(chrome, &format!("{} · {}", s.name, site.profile.name), &desc, &m))
}

fn not_found(chrome: &Chrome) -> String {
    let m = format!(
        "<div class=\"col col-home\"><div class=\"card a1 nf\"><b>404</b><span>Page not found.</span>\
         <a class=\"lsb\" href=\"/\"><span class=\"lbl\">Back home</span></a></div></div>"
    );
    shell(chrome, "Not found", "Page not found.", &m)
}

pub fn esc(s: &str) -> String {
    let mut out = String::with_capacity(s.len());
    for c in s.chars() {
        match c {
            '&' => out.push_str("&amp;"),
            '<' => out.push_str("&lt;"),
            '>' => out.push_str("&gt;"),
            '"' => out.push_str("&quot;"),
            c => out.push(c),
        }
    }
    out
}

/// Comment + whitespace stripping. Safe for our stylesheet: no strings with significant spaces,
/// and `calc()` operators keep their surrounding spaces (we only trim around punctuation).
fn minify_css(css: &str) -> String {
    let mut no_comments = String::with_capacity(css.len());
    let mut rest = css;
    while let Some(start) = rest.find("/*") {
        no_comments.push_str(&rest[..start]);
        rest = rest[start..].find("*/").map_or("", |end| &rest[start + end + 2..]);
    }
    no_comments.push_str(rest);
    let collapsed = no_comments.split_whitespace().collect::<Vec<_>>().join(" ");
    let mut out = String::with_capacity(collapsed.len());
    let bytes: Vec<char> = collapsed.chars().collect();
    for (i, &c) in bytes.iter().enumerate() {
        if c == ' ' {
            let prev = if i > 0 { bytes[i - 1] } else { '{' };
            let next = bytes.get(i + 1).copied().unwrap_or('}');
            if "{};,>".contains(prev) || "{};,>".contains(next) || prev == ':' {
                continue;
            }
        }
        out.push(c);
    }
    out.replace(";}", "}")
}

pub fn icon(paths: &str) -> String {
    format!("<svg class=\"i\" viewBox=\"0 0 24 24\" aria-hidden=\"true\">{paths}</svg>")
}

// Icons: simplified line glyphs (24px grid), stroked with currentColor via `.i` in site.css.
const CHEVRON_DOWN: &str = "<path d=\"m6 9 6 6 6-6\"/>";
const CHEVRON_BACK: &str = "<path d=\"m15 18-6-6 6-6\"/>";
const CHEVRON_FWD: &str = "<path d=\"m9 18 6-6-6-6\"/>";
const CHEVRON_UP: &str = "<path d=\"m18 15-6-6-6 6\"/>";
const CHEVRON_UP_SQUARE: &str = "<rect x=\"3\" y=\"3\" width=\"18\" height=\"18\" rx=\"4\"/><path d=\"m8 14 4-4 4 4\"/>";
// CupertinoIcons.keyboard_chevron_compact_down: keyboard over a small chevron
const KEYBOARD_CHEVRON: &str = "<rect x=\"2\" y=\"3\" width=\"20\" height=\"12\" rx=\"2\"/><path d=\"M6 7h.01M10 7h.01M14 7h.01M18 7h.01M7 11h10M9 19l3 2 3-2\"/>";
// CupertinoIcons.chart_bar_alt_fill: filled bars
const CHART_BAR: &str = "<path d=\"M5 20V12M10 20V5M15 20V9M20 20v-5\" stroke-width=\"3.5\" stroke-linecap=\"butt\"/>";
const LINK: &str = "<path d=\"M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71\"/><path d=\"M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71\"/>";
const MOON: &str = "<path d=\"M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z\"/>";
const SUN: &str = "<circle cx=\"12\" cy=\"12\" r=\"4\"/><path d=\"M12 2v2M12 20v2M4.9 4.9l1.4 1.4M17.7 17.7l1.4 1.4M2 12h2M20 12h2M6.3 17.7l-1.4 1.4M19.1 4.9l-1.4 1.4\"/>";
const CURSOR: &str = "<path d=\"m9 9 5 12 1.8-5.2L21 14Z\"/><path d=\"M7.2 2.2 8 5.1M5.1 8l-2.9-.8M14 4.1 12 6M6 12l-1.9 2\"/>";
const CURSOR_OFF: &str = "<path d=\"m9 9 5 12 1.8-5.2L21 14Z\"/><path d=\"M3 3l18 18\"/>";
const APPLE: &str = "<path d=\"M12 20.9c1.5 0 2.8 1.1 4 1.1 3 0 6-8 6-12.2A4.9 4.9 0 0 0 17 5c-2.2 0-4 1.4-5 2-1-.6-2.8-2-5-2a4.9 4.9 0 0 0-5 4.8C2 14 5 22 8 22c1.3 0 2.5-1.1 4-1.1Z\"/><path d=\"M10 2c1 .5 2 2 2 5\"/>";
const ANDROID: &str = "<path d=\"M5 18V11a7 7 0 0 1 14 0v7Z\"/><path d=\"M8 5 6.5 3M16 5l1.5-2M9.5 10h.01M14.5 10h.01\"/>";
const GLOBE: &str = "<circle cx=\"12\" cy=\"12\" r=\"10\"/><path d=\"M2 12h20M12 2a15 15 0 0 1 0 20 15 15 0 0 1 0-20\"/>";
const TABLET: &str = "<rect x=\"4\" y=\"2\" width=\"16\" height=\"20\" rx=\"2\"/><path d=\"M12 18h.01\"/>";
pub const COPY: &str = "<rect x=\"9\" y=\"9\" width=\"13\" height=\"13\" rx=\"2\"/><path d=\"M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1\"/>";
pub const CHECK: &str = "<path d=\"M20 6 9 17l-5-5\"/>";
const DESKTOP: &str = "<rect x=\"2\" y=\"3\" width=\"20\" height=\"14\" rx=\"2\"/><path d=\"M8 21h8M12 17v4\"/>";
