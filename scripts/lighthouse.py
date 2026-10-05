#!/usr/bin/env python3
"""Lighthouse (mobile, simulated slow 4G) over every page in dist/, with a markdown summary.

Starts its own static server on a free port, warms each URL first and retries once on Chrome's
CHROME_INTERSTITIAL_ERROR (a local-server startup race). Raw JSON -> perf/lighthouse/ (gitignored),
summary -> perf/lighthouse-<date>-<rev>.md.

usage: scripts/lighthouse.py [--out dist] [page ...]   (pages like / or /project/Eqalink/)
"""
import datetime, functools, http.server, json, os, pathlib, socket, subprocess, sys, threading, urllib.request

ROOT = pathlib.Path(__file__).resolve().parent.parent
CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
SKIP = {"404.html", "no-data.html"}
# Audits that only reflect the local test server (GitHub Pages serves gzip + max-age=600).
SERVER_ONLY = {"uses-long-cache-ttl", "uses-text-compression", "cache-insight", "document-latency-insight"}


def git(*args):
    try:
        return subprocess.run(["git", *args], cwd=ROOT, capture_output=True, text=True, check=True).stdout.strip()
    except Exception:
        return ""


def main():
    args = sys.argv[1:]
    out = ROOT / (args[args.index("--out") + 1] if "--out" in args else "dist")
    pages = [a for a in args if a.startswith("/")]
    if not pages:
        pages = sorted("/" + str(p.relative_to(out)).removesuffix("index.html")
                       for p in out.rglob("*.html") if p.name not in SKIP)

    sock = socket.socket(); sock.bind(("127.0.0.1", 0)); port = sock.getsockname()[1]; sock.close()
    handler = functools.partial(http.server.SimpleHTTPRequestHandler, directory=str(out))
    http.server.SimpleHTTPRequestHandler.log_message = lambda *a: None
    server = http.server.ThreadingHTTPServer(("127.0.0.1", port), handler)
    threading.Thread(target=server.serve_forever, daemon=True).start()

    date = datetime.date.today().isoformat()
    rev = git("rev-parse", "--short", "HEAD") + ("-dirty" if git("status", "--porcelain") else "")
    raw = ROOT / "perf" / "lighthouse"; raw.mkdir(parents=True, exist_ok=True)
    rows = []
    for page in pages:
        url = f"http://127.0.0.1:{port}{page}"
        urllib.request.urlopen(url).read()
        dest = raw / f"{date}-{page.strip('/').replace('/', '_') or 'home'}.json"
        for _attempt in range(2):
            subprocess.run(["npx", "-y", "lighthouse@12", url, "--quiet", "--chrome-flags=--headless=new",
                            "--only-categories=performance,accessibility,best-practices,seo",
                            "--output=json", f"--output-path={dest}"],
                           env={**os.environ, "CHROME_PATH": CHROME}, capture_output=True)
            d = json.loads(dest.read_text())
            if not d.get("runtimeError"):
                break
        if d.get("runtimeError"):
            rows.append(f"| `{page}` | error: {d['runtimeError']['code']} | | | | | | |")
            continue
        a, c, m = d["audits"], d["categories"], d["audits"]["metrics"]["details"]["items"][0]
        score = lambda k: round(c[k]["score"] * 100)
        flags = [k for k, v in a.items() if v.get("score") is not None and v["score"] < 0.9
                 and v.get("scoreDisplayMode") in ("binary", "numeric", "metricSavings") and k not in SERVER_ONLY]
        rows.append(f"| `{page}` | {score('performance')} | {score('accessibility')} | {score('best-practices')} | "
                    f"{score('seo')} | {a['first-contentful-paint']['displayValue']} | "
                    f"{a['largest-contentful-paint']['displayValue']} (observed {m['observedLargestContentfulPaint']} ms) | "
                    f"{a['total-byte-weight']['displayValue'].replace('Total size was ', '')} | {', '.join(flags) or '—'} |")
        print(rows[-1], flush=True)
    server.shutdown()

    md = (f"# Lighthouse {date} ({rev})\n\nMobile, simulated slow 4G, local server. "
          "Server-only audits (compression, cache TTL) excluded.\n\n"
          "| Page | Perf | A11y | BP | SEO | FCP | LCP | Weight | Flags |\n|---|---|---|---|---|---|---|---|---|\n"
          + "\n".join(rows) + "\n")
    path = ROOT / "perf" / f"lighthouse-{date}-{rev}.md"
    path.write_text(md)
    print(f"saved {path.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
