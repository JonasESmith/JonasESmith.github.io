# CONTEXT.md — Portfolio rewrite

Working context for rebuilding jonasesmith.github.io: the same look and feel as the current Flutter site, sourced from an Obsidian vault, with a **sub-400ms load**. Update the **Progress log** and **Perf reports** sections as work lands.

---

## 1. Goals

| Goal | Target |
|---|---|
| Load time (cold, mid-tier mobile, 4G) | < 400ms to LCP on a real connection. Content must be in the first HTML response. Lighthouse's simulated slow 4G (150ms RTT, 1.6Mbps) can't report much below ~0.8s FCP for any page, so track Lighthouse **Performance = 100 and LCP ≤ 1.2s** as the CI proxy. |
| Critical payload | HTML + inline CSS ≤ 14KB compressed (one TCP round trip). JS ≤ 10KB, deferred, never blocking render. |
| Content source | An Obsidian vault (markdown + frontmatter) feeds the build. No hardcoded content. |
| Look & feel | Keep: theme picker (Cmd+P palette + footer), light/dark, following-cursor glow, IDE-style footer, tilde gutter, staggered fades. |
| Images | Build-time AVIF compression, ASCII art, and dithering, all driven by flags in the vault markdown. |
| Privacy | `/no-data.html` is the privacy-policy URL in the App Store / Play Store listings. **Keep the URL and content exactly as they are**: it's copied byte-for-byte from `public/`. The rest of the site makes no third-party requests and only stores theme preferences in `localStorage`. |
| Mobile | First-class. Touch fallback for the cursor effect, footer reflow at < 600px. |

---

## 2. Current state (as of 2026-10-05)

### Repo / branches

- `master` == `rust-rewrite` (both at `0bba8e6`). This is the **Flutter build output committed at the repo root**, served by GitHub Pages.
- The Dioxus work lives on other branches (`master → dioxus-obsidian-builder → dioxus-text-viewer → dioxus-rust-port`).
  - Only **`dioxus-rust-port`** (`1b63dfb`) is worth mining. The other two are fully contained in it or superseded.
  - Read its files with `git show "dioxus-rust-port:rust-port/..."`.
- `rust-port/` and `image_manager/` in this working tree are gitignored leftovers: `target/` dirs of 3.1G and 1.2G, no source.
- `vault/` here is empty. The vault notes (`About me/`, `Skills/`, `Projects/`) live on the `dioxus-*` branches.

### Live Flutter site: baseline (measured 2026-10-05)

| Resource | Transferred (compressed) |
|---|---|
| `index.html` | 948 B |
| `main.dart.js` | **1.29 MB** (4.3 MB raw) |
| `canvaskit.wasm` | **2.0–2.7 MB** (6.7 MB raw; often fetched from gstatic, not locally) |
| Noto Sans | fetched from fonts.gstatic.com at runtime |

- Roughly **3.3 MB+ before first paint**. Content is painted to a canvas, so search engines see none of it and none of it is accessible.
- Root `index.html` has no viewport meta, description "A new Flutter project.", and title "portfolio".

### Flutter site: what it actually is

**Routes**
- `/home`: profile card plus the "Noteable Projects" and "Skills" lists. Column is 500px wide with 160px of top/bottom space.
- `/project/:title-with-dashes`: 900px column containing:
  - back/title pill
  - platform icons
  - technology chips
  - horizontal screenshot gallery that opens a fullscreen viewer
  - markdown body
- All other routes in `main_module.dart` are dead, including `/settings`, `/skills` and `/experience`.

**Content** is a hardcoded Dart literal in `lib/src/home/bloc/home_bloc.dart:72-788`.
- **Projects:** Eqalink, Portfolio, Rock Climber Guide, Better Fantasy System, Pakmo.
- **Skills:** Flutter, Rust, UI/UX, Python, .Net, Pencil Drawing, Wood Working.
- **Profile:**
  - Version string is the age since 1995-12-03, shown as `v{years}.{days}`.
  - Links: GitHub, Instagram, LinkedIn, email.
- The `dioxus-rust-port` copy, `rust-port/assets/work.json` (29KB), also has Yutori, Acro-yoga, and the MWI ASCII art.

**Shell**
- 20px `~` gutter on the left, vim-style.
- IDE status-bar footer:
  - Left group: [Dark/Light] [scheme name ⌃] [Mouse Shadow].
  - Right group: github / instagram / linkedin / email. On mobile (< 600px) this moves to a second row and drops email.

**Themes**
- 55 FlexColorScheme schemes, listed with hex values in the appendix.
- Default is "Midnight". **The scheme is force-reset to Midnight on every load** (`main.dart:27`), which is a bug. Mode follows the system.
- Picker: a Cmd+P palette that is 600px wide, top-centred, with search, ↑/↓ cycling and a sun/moon toggle. Each row shows three colour dots and a name.
- Surfaces are computed: Material 3, `levelSurfacesLowScaffold`, blend 7 (light) / 13 (dark).

**Cursor follower** (`vox_widgets` `VoxMouseFollower`)
- Radial gradient with stops `secondary@.12 → primary@.06 → tertiary@.03`.
- Two discs:
  - Big: 1000px, lags 700ms easeOutCubic.
  - Small: 300px, lags 1400ms easeOutCubic, orbiting the cursor at a 100px radius.
- Both spin slowly; one cycle takes a random 15–24s.
- Above them: 100σ blur over everything, plus 5000-dot white noise at 5%.
- Hover only, so nothing on touch. Can be toggled from the footer.

**Typography & colour**
- Noto Sans. Markdown body uses `bodySmall`.
- Links are #007AFF; visited links are #AF52DE.

**Motion**
- Home: 600ms delay, then a staggered fade and slide (card, then projects, then skills).
- Project page: 1200ms stagger (chips, then gallery, then body).

**Privacy**
- `no-data.html` reads "No Data is Collected — This application does not collect any personal data."
- It is linked from a footer in root `index.html`, but the Flutter canvas probably covers that footer.
- The page is **not quite true** today:
  - Google Fonts and gstatic CanvasKit fetches leak IPs to Google.
  - HydratedBloc/Hive write IndexedDB (all content, visited projects, theme).

**Hacks to drop**
- `build.sh` asset shuffling, which leaves duplicated `assets/` trees (65MB).
- The 404 sessionStorage redirect trick.
- `prevent_default.js` (blocks Cmd+P printing).
- Manual `main.dart.js` edits.
- `portfolio_data` (Rust → Dart quicktype codegen).

### dioxus-rust-port (previous rewrite attempt)

- Dioxus 0.7.1 with an Obsidian-style layout: sidebar file tree, content panel, light/dark theme, 7 OKLCH accent presets, a hand-rolled markdown parser (~1350 lines), ASCII image component, and image carousel.
- Release build: **wasm 262KB brotli** + JS 10.5KB + CSS 4.6KB (+ a 133KB favicon).
- That is much better than Flutter but still client-rendered, so wasm must download, compile and run before content shows.
- Gaps:
  - No cursor follower.
  - No privacy page.
  - Project screenshots are never rendered, but every image ships anyway.
  - The `/project/<slug>` links in content are broken (the route expects `i32`).

### diobsidian (`~/Projects/diobsidian`) — the pipeline we like

`frontend/build.rs` (2,317 lines) is the valuable part.

**Vault reading**
- Vault walk that skips dotfiles.
- Slugs with collision handling.
- Wikilinks `[[x|y]]`.
- Frontmatter:
  - Runtime parsing handles title, subtitle, author, start/end date and tags.
  - Build time extracts `title:` only.

**Image flags** go after the image ref, e.g. `![[img.png]] --dither --8 --accent`:
- `--ASCII`
- `--dither [--4|--8|--16]`
- `--accent`
- `--max`

**AVIF**
- EXIF orientation applied first.
- Resized to ≤ 1200w with Lanczos3.
- `ravif` starting at q85; each pass drops quality by 5 and scale by 0.05, until the file is ≤ 25KB.

**ASCII**
- `rascii_art`, width 120, charset `" ·∘:░▒▓█"`.
- Inverted for the light theme at runtime.

**Dither**
- Resize to ≤ 600w, convert to grayscale, quantise to N levels.
- Floyd–Steinberg error diffusion.
- Write a PNG:
  - `--accent`: grayscale, tinted at runtime with an accent overlay (`mix-blend-multiply`, 30%).
  - Otherwise: a baked navy→cream duotone, (20,22,40) → (240,235,220).

**Extras**
- Trigram search index, RSS, AES-GCM hidden notes, `diob` CLI.

**Runtime problems (why not reuse the runtime as-is)**
- Pure CSR: all page text, the search index and the dithered PNGs are compiled into the wasm, about 1.47MB of content.
- Nothing is prerendered.
- Markdown is re-parsed on every render.
- nginx has no compression.

**Known pipeline bugs to fix when porting**
- Standard `![alt](x.png)` images are processed but their paths are never rewritten.
- Output collisions on file stem (`a/foo.png` and `b/foo.jpg` both become `foo.avif`).
- `_` triggers italic inside snake_case.
- RSS is sorted by date *string*.
- The `.env` parser truncates values containing `=` or `#`.
- Search slices a UTF-8 string off a char boundary and panics, which is the likely "freeze" in diobsidian's `todo.md`.
- Pruning deletes tracked demo assets.
- Changing processing params doesn't invalidate cached outputs.

---

## 3. Architecture

**Static HTML generator in Rust (`gen/`). No client framework.**

```
vault/ (Obsidian) ──► gen build ──► dist/  (GitHub Pages)
  profile.md            vault.rs      frontmatter (serde_yaml) + body
  projects/*.md         markdown.rs   wikilinks / ![[embeds]] → pulldown-cmark
  skills/*.md           theme.rs      themes.toml → CSS custom props (surfaces derived)
  assets/**             assets.rs     image pipeline: AVIF 1x/2x + JPEG/PNG fallback, masks, dither, ASCII
                                      → .cache/img (hash-keyed) → dist/a/
public/ ──(verbatim)──► page.rs       templates; inline CSS + init script; deferred site.<hash>.js
                       report.rs     gen report → perf/<date>-<rev>.md
```

**Commands** (repo root):

| Command | What it does |
|---|---|
| `just build` | Builds `vault/` into `dist/` |
| `just build-drafts` | Also builds projects/skills marked `draft: true` |
| `just serve` | Serves `dist/` at `http://localhost:8000` |
| `just report` | Size and budget report, saved to `perf/` (gitignored, local only) |
| `just lighthouse /path/` | Lighthouse run against `just serve`; the JSON lands in `perf/lighthouse/` |
| `just check` | CI gate: build, then fail if any page is over budget (`gen report --check`) |
| `just lighthouse-all` | Lighthouse on every page. Starts its own server, warms each URL, retries interstitials. Summary goes to `perf/lighthouse-<date>-<rev>.md`. |

### CI / deploy (`.github/workflows/deploy.yml`)

One workflow handles everything:
- **Every push and PR:** build, then `report --check`; the size report goes to the job summary.
- **Pushes to `master` and manual runs:** additionally upload `dist/` and deploy to Pages.
- **Concurrency:** a newer push to the same ref cancels the older run.

Caching, modelled on horro_campaign's cached `dx` binary:

| Cache | Key | Effect |
|---|---|---|
| `bin/gen` (compiled generator) | hash of `gen/src`, `gen/static`, `themes.toml`, `Cargo.toml/lock` | Content-only pushes skip nasm, the Rust toolchain and the compile |
| Rust deps (`Swatinem/rust-cache`, `cache-on-failure`) | lockfile | Generator changes recompile only our crate |
| `.cache/img` | `assets.rs` hash + vault hash, prefix fallback | Only new or changed images encode |

Caches saved on `master` are readable by every branch; branch caches are readable only by that branch.

**One-time GitHub settings** (repo owner):
1. **Settings → Pages → Build and deployment → Source: GitHub Actions.** Leave Custom domain empty. HTTPS is automatic on github.io.
2. **Settings → Environments → `github-pages`** (created by step 1): Deployment branches should allow `master`. The default rule is the default branch, which is `master`.
3. **Settings → Actions → General:** Actions permissions must allow the actions used (`actions/*`, `dtolnay/rust-toolchain`, `Swatinem/rust-cache`); "Allow all actions" is the default. Workflow permissions can stay read-only, because the workflow requests `pages: write` / `id-token: write` itself.
4. No secrets are needed.

### Output

| Path | Contents |
|---|---|
| `/index.html` | Home |
| `/project/<Title-With-Dashes>/` | One page per project. Same URL scheme as the Flutter site, so old links still work. |
| `/404.html` | Not-found page |
| `/no-data.html` | Privacy notice, passed through unchanged |
| `/a/*` | Hashed assets |

### Page anatomy

Each page ships:
- complete prerendered HTML
- all CSS inline (~12KB raw, which includes the scheme variables)
- a ~300B inline `<head>` script that applies the stored mode and scheme before first paint, so there's no flash
- one deferred `site.<hash>.js`

### Behaviours that need no JS

- **About card:** `<details>`.
- **Visited links:** purple via native `a:visited`, including the icon tile.
- **Project icons:** recoloured via CSS `mask`.
- **Mode and scheme labels:** switched by CSS from `data-*` attributes.
- **Scheme picker:** the native `popover` attribute.

### JS (`gen/static/site.js`, 5.3KB raw, ~2KB br, deferred)

- **Toggles:** mode, scheme and follower, persisted to `localStorage` (keys `mode`, `scheme`, `follower`).
- **Palette:** Cmd/Ctrl+P toggles it, which also blocks the print dialog the way `prevent_default.js` did. Case-insensitive search; ↑/↓ cycle schemes and Enter closes. Opening it focuses the search field on pointer devices.
- **Cursor follower** (retuned 2026-10-05 at the owner's request: subtler, tapered, blurred, grainy):
  - **Glows:** two radial gradients with a tapered falloff (secondary 7% → 6% → primary 3.8% → 2% → tertiary 0.7% → transparent), about 40% fainter than Flutter's. The small 300px glow has a 24px blur and orbits the cursor at 100px via a CSS animation.
  - **Grain:** an inline SVG `feTurbulence` noise, thresholded into alpha specks (black on light at 11%, white on dark at 12%), so it reads as film grain rather than a grey tint. About 0.9KB inline, no request.
    - **The grain is anchored to the viewport.** A round mask travels with the big glow, and `site.js` counter-translates the grain plane inside it. The specks stay still and the glow sweeps across them, revealing different grain as the mouse moves. Both moves are compositor transforms, with no per-frame repaint.
    - Verified: the plane stays at (0,0) before, during and after the glow moves.
  - **Entrance:** invisible until the first mouse move, then placed at the cursor and faded in over 0.9s. No sweep in from a corner.
  - **Motion:** an exponential lerp approximates Flutter's 700ms / 1400ms easeOutCubic lag. The rAF loop runs only while catching up.
  - Touch devices and `prefers-reduced-motion`: fades in at rest (top-left) with no tracking. "Mouse Shadow" in the footer hides it.
- **Lightbox:** a native `<dialog>` with backdrop blur. Back pill, "Image n / N" pager, ←/→ keys, swipe, and Esc or backdrop click to close. Without JS the gallery links open the 2x AVIF directly.
- **Code blocks:** copy button with a check-mark confirmation for 2s.
- **Dates:** refreshes the version string and skill years at load; the HTML holds build-time values as the fallback.

### Build-time code highlighting (`gen/src/highlight.rs`)

- A small tokenizer emits one-letter span classes (comment, keyword, string, number, type, function, attribute/macro).
- Keyword sets: Rust, shell, JS/TS, Dart and Python; other languages get generic highlighting.
- Colours are Flutter's a11y-light / a11y-dark palettes.
- No runtime JS and no highlighting library.

### Accessibility

- **Contrast:** `theme.rs` derives `--link`, `--link-v` and `--p-text`, nudged per scheme until they reach ≥4.5:1 on every surface. Muted text uses `--muted` (72% on-surface), not the disabled colour.
- **Headings:** markdown headings are re-ranked to consecutive levels starting at h2, under the page-title h1. A `.hN` class keeps the authored size.

### Image pipeline (`gen/src/assets.rs`)

- **Naming:** output files are named by `hash(source bytes + operation + PIPELINE_VERSION)`. Pages render first; `finish()` then encodes the missing variants in parallel (one decode per source) into `.cache/img/` (gitignored) and copies them to `dist/a/`.
- **Build times:** cold 2.7s for 78 variants; warm 8ms.
- **Re-encoding:** bump `PIPELINE_VERSION` to re-encode everything, or `ASCII_VERSION` for ASCII art only.

| Use | Fit | Output |
|---|---|---|
| Gallery (`gallery:` frontmatter) | 600px tall | AVIF 1x q70 + 2x q56, JPEG/PNG fallback in `<picture>`. First image gets `fetchpriority=high`, images from the third on load lazily. |
| Avatar | 40px square crop | Same as gallery |
| Project icons | 32px PNG | Used as CSS `mask` |
| Inline `![[x]]` / `![](x)` | Within 880×720 | Same as gallery, lazy |
| Strip (consecutive images) | 320px tall | Same as gallery, lazy |
| `--dither [--4\|--8\|--16]` | ≤600px wide | Floyd–Steinberg. Palette PNG at minimal bit depth. Baked navy→cream duotone. |
| `--dither … --accent` | ≤600px wide | Grey palette tinted by the scheme primary via CSS `mix-blend-mode: multiply` |
| `--ascii` | 120 cols, ≤640px wide | 8 glyphs after a 2nd–98th percentile contrast stretch. Rendered as **inline SVG text**: authored at 12px, scaled by the viewBox, each line pinned with `textLength`, so audits don't see "illegible text". One variant for both modes, in the text colour, so it's a bright figure on dark and a silhouette on light. Inverting glyph density for light mode, the diobsidian approach, made a solid slab. |

- **Transparency:** real alpha is detected (not just an RGBA container). Opaque sources get JPEG fallbacks and RGB AVIF.
- **Orientation:** EXIF orientation is applied.
- **Formats:** WebP, GIF, PNG and JPEG sources are accepted. `dagger.png` is actually a WebP.
- **Fixed from diobsidian:**
  - standard `![]()` paths are now rewritten
  - output names can't collide (the hash is in the name)
  - changing params invalidates the cache (params are in the key)

### Vault content model

- **`profile.md`**
  - Frontmatter: `name`, `handle`, `birth_date`, `avatar`, `email`, `links[]`.
  - Body: the about text.
- **`projects/<Title>.md`**
  - Frontmatter: `title`, `description`, `order`, `draft`, `url`, `icon`, `start`, `end`, `platforms[]` (ios/android/web/ipad/macos), `technologies[{name,url}]`, `gallery[]` (file names).
  - Body: markdown.
- **`skills/<Name>.md`** (one page each at `/skill/<Name>/`, linked from the home skill rows)
  - Frontmatter: `name`, `order`, `draft`, `start`, `end`, `sub_skills[]`. Each sub-skill is either `- Bloc` or `- { name: Bloc, note: State management }`.
  - The page shows a span line ("since 2018 · 8.7 y"), a Toolbox list with the sub-skill notes, then the body. Galleries, ASCII art and dithering work in the body as in projects.
  - The file name is free, since the display name comes from frontmatter. Avoid leading dots: `.Net.md` was hidden by Obsidian, so it's now `DotNet.md`.
- **Links and embeds:**
  - `[[Name]]` and `[[Name|text]]` link to a project page, or failing that a skill page (case-insensitive).
  - Obsidian callouts (`> [!NOTE]`, `> [!TIP] Custom title`) render as a labelled blockquote.
  - `![[file]]` and `![[file|caption]]` embed images; consecutive embeds become a scrolling strip.
  - `![[art.txt]]` embeds ASCII art.
  - Assets are resolved by file name anywhere in the vault, as Obsidian does.

### Themes

- `gen/themes.toml` holds the curated list (first entry = default). Current picks: Midnight, Blue whale, Espresso and crema, Green forest, Rosewood, Shark and orange, Material 3 purple, Mosque cyan. Swap freely: all 55 originals are listed in Appendix A.
- Scaffold, card, footer-bar, footer-button, divider and on-primary colours are derived in `theme.rs` using constants **fitted to pixels sampled from the live Flutter site** (Midnight, 2026-10-05).
  - Live: scaffold `#141516` / `#fcfcfd`, divider `#383a3c` / `#d2d4d7`, footer bar `#161717` / `#fbfbfc`, footer buttons `#465262` / `#ccd4e1`.
  - Ours now matches within 1–3 levels per channel.
  - The fit is: scaffold = base + 1.4% primary; divider = on-surface at 18.5%; footer buttons = primary at 34% (dark) / 20% (light).
  - Other schemes use the same formulas, so they inherit the fit.

### Deliberate deviations from Flutter

- "Noteable" is fixed to "Notable".
- ↑/↓ cycle schemes only while the palette is open. Flutter cycled globally, but on the web that would hijack page scrolling.
- The cursor glow uses gradients that fade to transparent rather than a full-screen 100σ backdrop blur, which is too expensive on mobile GPUs. The 5% noise layer is dropped: under Flutter's blur it was invisible.
- Matching Flutter: the home column is vertically centred, and footer buttons carry the `secondaryHeaderColor` chip background.
- Glow, by owner request: subtler, tapered, blurred, with grain, and it fades in at the cursor on first move. Flutter's glow started in the top-left corner and swept to the cursor.
- Link colours are slightly darker in light mode and lighter in dark mode than iOS #007AFF / #AF52DE, to pass WCAG AA.
- The scheme persists between visits; Flutter reset it to Midnight on every load.
- Entrance animations start immediately and finish within 600ms. Flutter waited 600ms first.
- The broken profile link (BFS → Eqalink) is fixed.
- Yutori and Acro-yoga from the Dioxus `work.json` were migrated as `draft: true`, then published on 2026-10-06 at the owner's request.
- Skills are clickable and have their own pages; the Flutter skill rows were not links.
- Projects without an `icon` show their first letter in the tile (Midwestern Interactive, Yutori).

---

## 4. Decisions

| # | Decision | Status |
|---|---|---|
| 1 | Layout | **Flutter layout**: 500px home column, 900px project page, tilde gutter, IDE footer |
| 2 | Themes | **Curated shortlist**; scheme and mode **persist between visits** |
| 3 | Font | **System UI stack**; no web-font request |
| 4 | Generator home | **New crate in this repo**: `gen/` |
| 5 | Privacy | **`/no-data.html` unchanged**: same URL, same content (store listings point at it) |
| 6 | Deploy | **GitHub Actions → Pages** (`deploy.yml` on push to `master`), with the Flutter build removed from the repo. No custom domain for now: `www.jonasesmith.com` is a Namecheap parking page. To use it later, point DNS at Pages and add `public/CNAME`. |
| 7 | Extra content | **Published** (2026-10-06): Yutori, Acro-yoga, and Midwestern Interactive as the current role. Project order puts the newest first: MWI, Yutori, then the Flutter-era list. |

---

## 5. Plan (phases)

- [x] **P0 Discovery:** inventory, baseline.
- [x] **P1 Decisions:** layout, themes, font and generator location locked. Vault content model defined and content migrated from `work.json` plus the Flutter profile text.
- [x] **P2 Generator skeleton:**
  - vault → HTML for home, projects and 404
  - inline CSS, theme bootstrap, footer, scheme popover, mode toggle
  - size report
- [x] **P3 Image pipeline** (done 2026-10-05; see §3 "Image pipeline"). Original plan:
  - **AVIF:**
    - Port diobsidian's AVIF encoding. Install `nasm` for a fast rav1e build.
    - Responsive sizes (`srcset`): gallery images at ~600px height ×1/×2, avatar 40px ×2, icons 20px ×2.
  - **ASCII + dither flags:** `--ASCII` and `--dither [--4|--8|--16] [--accent]` on embeds.
  - **Cache:** keyed by hash(source bytes + params) under `.cache/`.
  - **Known diobsidian bugs to fix in the port:**
    - standard `![](x)` image paths are never rewritten
    - output names collide on file stem
    - changing params doesn't invalidate cached outputs
- [x] **P4 Look & feel** (done 2026-10-05; see §3 JS / highlighting / accessibility). Original plan:
  - Cursor follower: rAF lerp; CSS `filter: blur` on the blobs; off for `pointer: coarse` and reduced motion.
  - Cmd+P palette: search, and ↑/↓ to cycle schemes.
  - Gallery lightbox with `<dialog>`; each gallery link already points at the 2x AVIF.
  - Code blocks: build-time syntax highlighting and a copy button.
  - Fix a11y: colour contrast (#007AFF on dark), heading order on project pages.
- [x] **P5 Perf hardening** (done 2026-10-05). Original plan:
  - Check light-mode surfaces against the live site.
  - Preload the LCP image. *Not needed:* the first screenshot is already in the initial HTML with `fetchpriority=high`, and observed LCP is 41–322ms locally.
  - CI budget check that fails `gen report` when over budget.
  - Lighthouse on every page.
- [x] **P6 Deploy** (live 2026-10-05, `master` @ `00c87ef`). Original plan:
  - Actions → Pages.
  - Remove the Flutter build artifacts and sources from `master`: `lib/`, `canvaskit/`, `assets/`, `images/`, `main.dart.js`, platform folders, `portfolio_data/`, `compress_images/`.
  - Delete the gitignored `rust-port/target` and `image_manager/target` directories locally (~4.3G).
  - Keep `no-data.html` reachable at the same URL throughout.

---

## 6. Perf reports

`just report` writes per-page detail to `perf/`. Summary:

| Date | Build | Route | HTML (br) | Blocking | JS | First-view bytes | Lighthouse mobile (perf / LCP) | Notes |
|---|---|---|---|---|---|---|---|---|
| 2026-10-05 | Flutter `0bba8e6` (live) | `/` | 0.9KB | — | 1.29MB + 2.0–2.7MB wasm | ~3.3MB+ | not run | Baseline. Canvas render, gstatic CanvasKit, Google Fonts. |
| 2026-03-28 | dioxus-rust-port (local) | `/` | 4.9KB | — | 10.5KB + 262KB wasm | ~280KB | — | Client-rendered. |
| 2026-10-05 | gen P2 | `/` | 5.2KB | 0 | 1.5KB | 250KB | **100 / 1.1s** | The LCP element is the avatar (128KB JPEG at 40px). P3 brings it to ~3KB. |
| 2026-10-05 | gen P2 | `/project/Eqalink/` | 5.4KB | 0 | 1.5KB | 5.9MB (14MB lazy) | 75 / 67s | Raw PNG screenshots, 1.6–3.2MB each. Needs P3. |
| 2026-10-05 | gen P3 | `/` | 5.5KB | 0 | 1.5KB | 14KB | **100 / 1.1s** | Avatar is now a 1.2KB AVIF. 32KB total. |
| 2026-10-05 | gen P3 | `/project/Eqalink/` | 5.7KB | 0 | 1.5KB | 60KB (192KB lazy) | **100 / 1.7s** | 232KB total, down from 18MB |
| 2026-10-05 | gen P3 | `/project/Rock-Climber-Guide/` | 5.8KB | 0 | 1.5KB | 70KB (150KB lazy) | **100 / 1.7s** | |
| 2026-10-05 | gen P3 | `/project/Better-Fantasy-System/` | 5.6KB | 0 | 1.5KB | 83KB (95KB lazy) | **100 / 1.5s** | |
| 2026-10-05 | gen P3 | `/project/Pakmo/` | 5.1KB | 0 | 1.5KB | 33KB | **100 / 1.2s** | |
| 2026-10-05 | gen P4 | `/` | 6.4KB | 0 | 5.3KB (≈2KB br) | 17KB | **100 / 1.2s**; a11y, best practices and SEO 100 | Palette, glow, lightbox, highlighting added |
| 2026-10-05 | gen P4 | `/project/Eqalink/` | 6.9KB | 0 | ≈2KB br | 63KB | **100 / 1.7s**; a11y, best practices and SEO 100 | |
| 2026-10-05 | gen P4 | `/project/Portfolio/` | 6.4KB | 0 | ≈2KB br | 10KB | **100 / 1.1s**; a11y, best practices and SEO 100 | Highlighted code blocks |
| 2026-10-05 | gen P4 | `/project/Rock-Climber-Guide/` | 6.9KB | 0 | ≈2KB br | 72KB | **100 / 1.7s**; a11y, best practices and SEO 100 | |
| 2026-10-05 | **live** `00c87ef` | `/` | 8.4KB gz | 0 | 2.3KB gz | 20KB total | **100 / 0.8s**; all categories 100 | GitHub Pages with real gzip |
| 2026-10-05 | **live** `00c87ef` | `/project/Eqalink/` | 8.7KB gz | 0 | 2.3KB gz | 211KB total | **100 / 1.2s**; all categories 100 | |

**Real-network cold loads of the live site** (puppeteer, fresh context, cache disabled, mobile viewport, median of 5):

| Network | Page | FCP | LCP | Load |
|---|---|---|---|---|
| Unthrottled | `/` | 112ms | 112ms | 111ms |
| Unthrottled | `/project/Eqalink/` | 100ms | 100ms | 134ms |
| Unthrottled | `/project/Rock-Climber-Guide/` | 116ms | 116ms | 168ms |
| 4G (60ms RTT, 9Mbps) | `/` | 148ms | 148ms | 214ms |
| 4G (60ms RTT, 9Mbps) | `/project/Eqalink/` | 132ms | 300ms | 281ms |
| 4G (60ms RTT, 9Mbps) | `/project/Rock-Climber-Guide/` | 148ms | 312ms | 282ms |

**The sub-400ms goal is met**, including LCP on the screenshot-heavy pages. For comparison, the Flutter site needed about 3.3MB before first paint.

Lighthouse notes:
- **The LCP number is mostly simulation.** Observed LCP locally is 32–38ms on every page. Lighthouse picks the `~` gutter text as the LCP element, because the gallery fades in from `opacity:0` and Chrome excludes it. The simulated LCP (1.5–1.7s on slow 4G) then charges the high-priority 2x screenshots that download alongside it. If the screenshots should count as the LCP, drop the `b2` fade on `.gallery`.
- The local `http.server` has no compression or cache headers, so ignore the text-compression and cache-TTL audits. GitHub Pages serves gzip with `max-age=600`.
- Accessibility is 100 since P4 (contrast and heading order fixed). The remaining non-scored flag is `unused-css-rules`: one inline stylesheet serves all page types, about 2KB of rules that are unused on any given page. That's acceptable at this size.
- In Lighthouse runs, the first run after starting `just serve` sometimes fails with `CHROME_INTERSTITIAL_ERROR`. Rerun it.

---

## 7. Progress log

- **2026-10-05**
  - Discovery done; `CONTEXT.md` created; baseline measured.
- **2026-10-05**
  - **Decisions:** Flutter layout, curated persistent themes, system font, `gen/` crate. Privacy page stays exactly as-is.
  - **Vault:** migrated `vault/` (profile, 6 projects with 1 draft, 8 skills with 1 draft, 29 source images).
  - **Generator (`gen/`):** built with `just build/serve/report/lighthouse`. 7 pages in 68ms.
  - **Results:**
    - Home scores Lighthouse Performance 100.
    - HTML is ~5KB brotli per page; no render-blocking requests.
  - **Next:** P3 images.
- **2026-10-05 (P3)**
  - **Pipeline:** installed `nasm`. Built the image pipeline in `gen/src/assets.rs`: AVIF 1x/2x with fallbacks, icon masks, indexed-PNG dither, ASCII with light/dark variants, a hash-keyed cache and parallel encoding.
  - **Syntax:** the markdown preprocessor handles `--ascii/--dither/--4/--8/--16/--accent`, standard `![]()` images and strips. Verified on a scratch vault; unknown flags and missing files warn instead of failing.
  - **Sizes:** `dist/` went from 28MB to 2MB.
  - **Lighthouse:** Performance 100 on all 5 pages tested.
  - **Report fix:** `gen report` now counts the largest AVIF candidate in `<picture>` rather than the fallback.
  - **Next:** P4 look & feel.
- **2026-10-05 (P4)**
  - Committed P0–P3 as `ee8cc46`.
  - Built: Cmd+P palette with search, cursor-follower glow, `<dialog>` lightbox, build-time highlighting with copy buttons, contrast-safe link/text colours per scheme, heading re-ranking.
  - Lighthouse: 100 in every category on 4 pages.
  - Verified with a puppeteer-core script: glow tracking, palette filter, mode persistence, lightbox paging, code blocks in both modes, mobile layout. No console errors.
  - **Next:** P5 (compare surfaces against the live Flutter site, CI budget check), then P6 deploy.
- **2026-10-05 (P5)**
  - Committed P4 as `da0bee1`.
  - Screenshotted the live Flutter site (puppeteer, both modes), sampled surface colours and fitted `theme.rs`. Fixed the layout differences found: vertical centring, glow origin, footer chip colour, keyboard and filled-bars icons.
  - Added `gen report --check` (verified: exit 1 on an oversized page, 0 when clean), `just check`, the CI workflow, and `scripts/lighthouse.py` / `just lighthouse-all`.
  - Lighthouse (mobile, simulated slow 4G, local server): 100 in all four categories on all 6 content pages. FCP 0.8–1.1s, simulated LCP 1.1–1.7s (observed 41–322ms), page weight 36–242 KiB.
  - Remaining non-scored flags:
    - `unused-css-rules` (one shared inline stylesheet).
    - `uses-responsive-images`: the Lighthouse device is DPR 1.75, so 2x is slightly larger than needed. A 1.5x variant would shave ~15KB per page; not worth it yet.
  - **Next:** P6 deploy. Measure real-network load on GitHub Pages afterwards, since the <400ms goal can only be confirmed there.
- **2026-10-05 (P6)**
  - Committed P5 as `d1302ce`.
  - Added `deploy.yml` (build → `report --check` → upload-pages-artifact → deploy-pages); `ci.yml` now skips `master`.
  - Removed 374 Flutter files from git: the build output at the root, `lib/`, the platform folders, `images/`, `assets/`, `canvaskit/`, `portfolio_data/`, `compress_images/`. The vault holds byte-identical copies of the source images.
  - `public/flutter_service_worker.js` is a kill switch: the old site registered a service worker that would keep serving cached Flutter to returning visitors.
  - `public/home/` redirects the old `/home` route.
  - `/no-data.html` verified byte-identical to the live copy.
  - Pushed `rust-rewrite` (`367c5e8`); CI is green on GitHub.
  - Follower retune (owner request): subtler tapered/blurred glows, film grain, fade-in at the cursor. Verified with puppeteer: opacity 0 before the first move, placed at the exact cursor position, faded to 1, no errors. Lighthouse still 100 on all categories.
  - **2026-10-05, go-live:**
    - The owner switched Pages to GitHub Actions and merged PR #4 (squash). The first deploy job was cancelled in GitHub's queue during an Actions incident; the build job had succeeded.
    - At the owner's request, the Claude co-author trailers were removed from the squash commit and `master` was force-pushed: `eec18ca` → `00c87ef`, same tree. GitHub's contributors API lists only JonasESmith; the repo page's contributors widget refreshes on GitHub's cache schedule.
    - The deploy for `00c87ef` succeeded: build 10s (cached generator), deploy 10s.
    - Verified live:
      - all 6 pages return 200 (about 8KB gz)
      - slash-less URLs and `/home` redirect
      - `/no-data.html` is byte-identical
      - the service-worker kill switch is served
      - the 404 page works
    - Lighthouse on live: 100 in all categories. Real-network cold loads 100–312ms (table in §6).
    - Follow-ups:
      - Delete the merged `rust-rewrite` branch, which still holds the original commits with trailers.
      - Delete local leftovers `rust-port/` and `image_manager/` (4.3G of build caches).
      - Optionally: update `vault/projects/Portfolio.md` (it still describes the Flutter build), and connect `www.jonasesmith.com`.
  - **Switch-over order (as planned):**
    1. Pages Source → GitHub Actions. This is a repo setting and needs the owner, since `gh` isn't installed here. The old deployment keeps serving until a new one lands.
    2. Merge `rust-rewrite` into `master` and push.
    3. `deploy.yml` publishes.
    4. Verify live: pages, `/no-data.html` bytes, real-network timing.

---

- **2026-10-06 (content + skill pages)**
  - Reviewed the notes on branch `dioxus-rust-port` (`About me/Work.md`, `Life.md`, `Skills/Drawing.md`, `work.json`) and brought them in:
    - The about text was updated to the current role and 8 years.
    - Midwestern Interactive was added; Yutori and Acro-yoga were published.
    - Sub-skill notes were restored.
    - The three portrait drawings were added (originals were AVIF, converted to PNG because the pipeline doesn't decode AVIF).
    - ASCII art is generated from the source photos (`vault/assets/ascii/`).
    - Writing was tightened, using only facts present in the notes.
  - Generator changes: skill pages, wikilinks to skills, Obsidian callouts, letter tiles, ASCII as SVG text.
  - Lighthouse: 100 in all four categories on all 16 content pages.
  - The Lighthouse runner now skips redirect stubs and names `/` as `index` (`/` and `/home/` used to overwrite each other). `/home/` gained a favicon link, which removed a console 404.

---

## Appendix A: Theme schemes (light P/S/T | dark P/S/T)

Order matches the Flutter picker.

- **Midnight** (default): #00296B/#D26900/#5C5C95 | #B1CFF5/#FFD270/#C9CBFC
  - Light containers: primaryContainer #A0C2ED, secondaryContainer #FFD270, tertiaryContainer #C8DBF8.
  - Dark containers: primaryContainer #3873BA, secondaryContainer #D26900, tertiaryContainer #535393.
- **Greens:** primary #065808 (light) / #629F80 (dark); the rest are computed.
- **Red & Blue:** #1145A4/#B61D1D; dark is `toDark(30)`.
- **Built-ins** (FlexColorScheme 7.3.1, `flex_color.dart:4866-4918`): Material, Material HC, Blue delight, Indigo nights, Hippie blue, Aqua blue, Brand blues, Deep blue sea, Pink sakura, Oh Mandy red, Red tornado, Red red wine, Purple brown, Green forest, Green money, Green jungle, Grey law, Willow and wasabi, Gold sunset, Mango mojito, Amber blue, Vesuvius burned, Deep purple, Ebony clay, Barossa, Shark and orange, Big stone tulip, Damask and lunar, Bahama and trinidad, Mallard and valencia, Espresso and crema, Outer space stage, Blue whale, San Juan blue, Rosewood, Blumine, Flutter Dash, M3 purple, Verdun green, Dell genoa green, Thunderbird red, Lipstick pink, Eggplant purple, Indigo San Marino, Endeavour blue, Mosque cyan, Blue stone teal, Camarone green, Verdun lime, Yukon gold yellow, Brown orange, Rust deep orange.
- Generate `themes.css` straight from `~/.pub-cache/hosted/pub.dev/flex_color_scheme-7.3.1/lib/src/flex_color.dart` rather than hand-copying.

## Appendix B: Key file references

**Flutter**
- `lib/src/home/bloc/home_bloc.dart:72-788`: content
- `lib/src/projects/projects_page.dart`: home layout and animation
- `lib/src/project/project_page.dart`: project layout
- `lib/src/core/widgets/page_footer.dart`: footer
- `lib/src/core/widgets/page_settings_wrapper.dart`: palette
- `~/.pub-cache/hosted/pub.dev/vox_widgets-0.1.31/lib/src/widgets/vox_mouse_follower.dart`: cursor follower

**Dioxus port** (branch `dioxus-rust-port`)
- `rust-port/assets/work.json`
- `rust-port/src/views/markdown.rs`
- `rust-port/src/components/ascii_image.rs`
- `rust-port/src/accent.rs`
- `rust-port/index.html`: no-flash theme script

**diobsidian**
- `frontend/build.rs`:
  - images: 1157-1541
  - wikilinks: 1654-1744
  - slugs: 22-87
  - env: 2154-2201
- `frontend/src/components/markdown.rs`
- `frontend/src/components/latex.rs`
- `.github/workflows/deploy.yml`
