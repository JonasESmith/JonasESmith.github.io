# syntax=docker/dockerfile:1
# Build vault/ -> dist/ with the generator, then serve dist/ with nginx.
# Used by `just docker` for LAN testing. Production still deploys via GitHub Pages.

FROM rust:1-slim-bookworm AS build
# nasm: rav1e (AVIF encoder) asm, same as CI
RUN apt-get update && apt-get install -y --no-install-recommends nasm && rm -rf /var/lib/apt/lists/*
WORKDIR /site
COPY gen/ gen/
# Cache mounts keep the cargo registry and target dir across builds, so only
# generator source changes recompile.
RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/site/gen/target \
    cargo build --release --manifest-path gen/Cargo.toml \
 && cp gen/target/release/gen /usr/local/bin/gen
COPY vault/ vault/
COPY public/ public/
ARG DRAFTS=""
# Encoded images persist in a cache mount, like .cache/img locally and in CI.
RUN --mount=type=cache,target=/site/.cache/img \
    gen build ${DRAFTS:+--drafts}

FROM nginx:1-alpine
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /site/dist /usr/share/nginx/html
EXPOSE 80
