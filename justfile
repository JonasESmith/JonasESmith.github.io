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

# Build the site image and run it on the LAN (starts Docker Desktop if needed). Usage: just docker [port] [drafts]
docker port="8080" drafts="":
	#!/usr/bin/env bash
	set -euo pipefail
	if ! docker info >/dev/null 2>&1; then
		echo "Starting Docker Desktop..."
		open -a Docker
		for _ in $(seq 90); do docker info >/dev/null 2>&1 && break; sleep 1; done
		docker info >/dev/null 2>&1 || { echo "Docker did not start within 90s (check Docker Desktop for a setup or password prompt, then rerun)" >&2; exit 1; }
	fi
	docker build -t portfolio-site --build-arg DRAFTS={{drafts}} .
	docker rm -f portfolio-site >/dev/null 2>&1 || true
	docker run -d --name portfolio-site --restart unless-stopped -p {{port}}:80 portfolio-site >/dev/null
	ip=$(ipconfig getifaddr en0 || ipconfig getifaddr en1 || echo localhost)
	echo "Serving on http://localhost:{{port}}  (LAN: http://$ip:{{port}})"
	echo "Stop with: just docker-stop"

# Stop and remove the `just docker` container
docker-stop:
	docker rm -f portfolio-site
