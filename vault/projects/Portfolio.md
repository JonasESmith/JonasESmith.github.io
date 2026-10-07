---
title: "Portfolio"
description: "A looking glass into my projects, work, and love for building"
order: 4
draft: false
icon: "dagger.png"
start: "2023-06-01"
platforms:
  - "ios"
  - "android"
  - "web"
  - "macos"
technologies:
  - name: "Flutter"
    url: "https://flutter.dev/"
  - name: "React"
  - name: "Rust"
    url: "https://www.rust-lang.org/"
  - name: "Bloc"
    url: "https://pub.dev/packages/bloc"
  - name: "Firebase"
    url: "https://firebase.google.com/"
  - name: "Freezed"
    url: "https://pub.dev/packages/freezed"
  - name: "FlutterModular"
    url: "https://pub.dev/packages/flutter_modular"
---

I wanted to create a simple, yet beautiful adaptive site to show the many things I like to work on.

> [!NOTE] Two versions
> The first version was a [[Flutter]] web app. The current one is a small [[Rust]] static site generator that turns my Obsidian notes into plain, prerendered HTML. It kept the look: themes, light and dark mode, the cursor glow and the IDE-style footer.

## Why move off Flutter?

Flutter web paints the whole page onto a canvas. Before anything showed up, a visitor downloaded about **3.3 MB**: a 1.29 MB `main.dart.js` and 2–2.7 MB of CanvasKit WebAssembly, plus fonts from Google. Because the text lived in a canvas, search engines and screen readers saw none of it.

The Rust version does all of that work once, at build time. Each page arrives as finished HTML with its CSS inline, and about 2 KB of deferred JavaScript adds the interactive bits.

## By the numbers

| | Flutter | Rust |
|---|---|---|
| Downloaded before first paint | ~3.3 MB | **18 KB** (home page) |
| JavaScript | 1.29 MB + 2–2.7 MB wasm | **~2 KB**, deferred |
| The entire site: every page and image size | — | **2.4 MB** |
| Lighthouse (mobile) | not measured | **100** in all four categories, every page |
| Visible to search engines and screen readers | No | Yes |

**Per page.** HTML is what GitHub Pages sends compressed. First view is everything needed to show the top of the page; lazy images load as you scroll.

| Page | HTML | First view | Lazy |
|---|---|---|---|
| Home | 8.7 KB | 17.7 KB | — |
| [[Eqalink]] | 8.6 KB | 63.3 KB | 191.6 KB |
| [[Rock Climber Guide]] | 8.8 KB | 73.0 KB | 149.7 KB |
| [[Better Fantasy System]] | 8.4 KB | 86.1 KB | 94.6 KB |
| [[Pakmo]] | 7.9 KB | 36.3 KB | — |
| A skill page | ~7.5 KB | ~10 KB | — |

**Real cold loads** of the live site on a 4G connection (60 ms latency, 9 Mbps, median of 5):

| Page | First paint | Largest paint | Fully loaded |
|---|---|---|---|
| Home | 148 ms | 148 ms | 214 ms |
| [[Eqalink]] | 132 ms | 300 ms | 281 ms |
| [[Rock Climber Guide]] | 148 ms | 312 ms | 282 ms |

Every page is fully drawn in about a third of a second, screenshot-heavy ones included.

## What Rust brings

- **Speed where it matters.** The whole site builds in under 100 ms. The slow part, encoding images, is cached by content, so only new or changed images are re-encoded.
- **An image pipeline.** About 30 MB of source photos and screenshots become 1.9 MB of AVIF at 1x and 2x, with JPEG/PNG fallbacks. ASCII art and dithering are generated at build time from a flag after the image, like `--ascii` or `--dither`.
- **Mistakes caught before deploying.** A note with a missing field, or two notes claiming the same URL, stops the build with the file named. Size budgets run in CI, so a page can't quietly grow past 14 KB of HTML.
- **Nothing to run in the browser.** No framework, no hydration and no third-party requests. Code blocks like the ones below are highlighted at build time.
- **Writing stays simple.** Every page is an Obsidian note. `[[Links]]` between notes become links on the site, and callouts, galleries and tables just work.

A skill page, for example, is just this:

```yaml
---
name: "Rust"
start: "2023-05-01"
sub_skills:
  - { name: "Serde", note: "Typed frontmatter parsing" }
---

Notes about the skill go here.
```

## Where Rust started

Rust first showed up in the Flutter version, generating the Dart data models through [flutter_rust_bridge](https://cjycode.com/flutter_rust_bridge/):

```rust
#[derive(Deserialize, Serialize, JsonSchema)]
pub struct AppData {
    pub nav_width: i32,
    pub profile: Profile,
    pub skills: Vec<Skill>,
    pub projects: Vec<Project>,
    pub work: Vec<WorkExperience>,
}
```

The generator grew out of that same idea: describe the content once, in typed Rust, and let the build do the rest.
