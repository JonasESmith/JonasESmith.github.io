# Portfolio

Jonas E. Smith's portfolio — [jonasesmith.github.io](https://jonasesmith.github.io).

Content lives in an Obsidian vault (`vault/`). A small Rust generator (`gen/`) turns it into
prerendered static HTML with build-time image processing (AVIF, dithering, ASCII art), so pages
load with no framework and almost no JavaScript.

## Requirements

- [Rust](https://rustup.rs) (stable)
- [just](https://github.com/casey/just)
- `nasm` (fast AVIF encoding): `brew install nasm`
- Node.js, only for Lighthouse reports

## Usage

```bash
just build          # vault/ -> dist/
just serve          # build + http://localhost:8000
just check          # build + fail if any page is over its size budget
just report         # size/budget report -> perf/
just lighthouse-all # Lighthouse on every page -> perf/
```

Push to `master` to deploy (GitHub Actions → Pages).

## Writing content

- `vault/profile.md`, `vault/projects/*.md`, `vault/skills/*.md` — YAML frontmatter + markdown.
- Link projects with `[[Project]]` or `[[Project|text]]`.
- Images: `![[file.png]]` or `![caption](path/file.png)`; consecutive image lines form a strip.
  Flags after an image: `--dither [--4|--8|--16] [--accent]`, `--ascii`.
- `draft: true` hides a page (`just build-drafts` to preview).

See [CONTEXT.md](CONTEXT.md) for architecture, decisions, perf history and progress.

`public/` is copied verbatim — `public/no-data.html` is the privacy policy linked from the app
store listings; keep its URL and content unchanged.
