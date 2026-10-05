gen := "cargo run --quiet --release --manifest-path gen/Cargo.toml --"

# Build the static site from vault/ into dist/
build:
	{{gen}} build

# Build including draft projects/skills
build-drafts:
	{{gen}} build --drafts

# Build and serve dist/ on http://localhost:8000
serve: build
	python3 -m http.server 8000 --directory dist

# Build, then write a size/budget report to perf/
report: build
	{{gen}} report

# CI gate: build and fail if any page is over budget
check: build
	{{gen}} report --check

# Lighthouse every page (own server, retries) and write perf/lighthouse-<date>-<rev>.md
lighthouse-all: build
	scripts/lighthouse.py

# Lighthouse (mobile, simulated slow 4G) against a running `just serve`. Usage: just lighthouse /project/Eqalink/
lighthouse path="/":
	mkdir -p perf/lighthouse
	CHROME_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" npx -y lighthouse@12 "http://localhost:8000{{path}}" --quiet --chrome-flags="--headless=new" --only-categories=performance,accessibility,best-practices,seo --output=json --output-path="perf/lighthouse/$(date +%F)-$(echo '{{path}}' | tr -c 'A-Za-z0-9\n' '_').json"
