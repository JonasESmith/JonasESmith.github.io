# Lighthouse 2026-10-05 (da0bee1-dirty)

Mobile, simulated slow 4G, local server. Server-only audits (compression, cache TTL) excluded.

| Page | Perf | A11y | BP | SEO | FCP | LCP | Weight | Flags |
|---|---|---|---|---|---|---|---|---|
| `/` | 100 | 100 | 100 | 100 | 0.9 s | 1.2 s (observed 43 ms) | 42 KiB | unused-css-rules |
| `/project/Better-Fantasy-System/` | 100 | 100 | 100 | 100 | 0.8 s | 1.5 s (observed 41 ms) | 111 KiB | unused-css-rules, uses-responsive-images, image-delivery-insight |
| `/project/Eqalink/` | 100 | 100 | 100 | 100 | 0.9 s | 1.7 s (observed 53 ms) | 242 KiB | unused-css-rules, uses-responsive-images, image-delivery-insight |
| `/project/Pakmo/` | 100 | 100 | 100 | 100 | 0.8 s | 1.2 s (observed 112 ms) | 60 KiB | unused-css-rules, image-delivery-insight |
| `/project/Portfolio/` | 100 | 100 | 100 | 100 | 0.9 s | 1.1 s (observed 203 ms) | 36 KiB | unused-css-rules |
| `/project/Rock-Climber-Guide/` | 100 | 100 | 100 | 100 | 1.1 s | 1.7 s (observed 322 ms) | 194 KiB | max-potential-fid, unused-css-rules, image-delivery-insight |
