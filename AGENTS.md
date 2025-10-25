# Repository Guidelines

## Project Overview

ipinfo.tw is a self-hosted IP information service that surfaces the caller's IP address, country code/name, ASN number/description, and user agent. The entire stack is nginx plus the GeoIP2 module: requests trigger lookups against MaxMind's GeoLite2 databases and responses are emitted as static text or JSON.

## Project Structure & Module Organization

Source assets live under the repository root. `Dockerfile` and `docker-compose.yml` produce the nginx-based image that serves all endpoints. Runtime configuration sits in `nginx/`: the top-level `nginx.conf` sets global directives, while `nginx/conf.d/*.conf` defines feature-specific locations such as `/json` and `/build_epoch`. Shell utilities and automation hooks belong in `hooks/`; `hooks/build` encapsulates the canonical image build. Keep project documentation (e.g. `README.md`) in the root to mirror existing layout.

Key configuration files and their roles:

- `nginx/conf.d/geoip2.conf` loads GeoLite2-Country and GeoLite2-ASN databases and defines commonly used variables (e.g. `$ip_country_code`, `$ip_country_name`, `$ip_asn`, `$ip_aso`); the file also carries build epoch values consumed by `/build_epoch`
- `nginx/conf.d/realip.conf` trusts `X-Real-IP` headers from RFC1918 private networks so reverse proxies can pass client addresses
- `nginx/conf.d/ipinfo.conf` holds the location blocks for `/`, `/json`, `/ip`, and other field endpoints, assembling text or JSON from nginx variables
- `nginx/nginx.conf` sets worker counts, event handling, and HTTP defaults

## Build, Test, and Development Commands

Set `MAXMIND_LICENSE_KEY` before building so the Dockerfile can fetch the GeoLite2 databases. Our Docker Hub automation (and local builds when needed) exports that variable alongside `DOCKERFILE_PATH=Dockerfile` and `IMAGE_NAME=ipinfo.tw:local` before calling `hooks/build`. For ad-hoc work you can run `docker build --build-arg MAXMIND_LICENSE_KEY=$YOUR_KEY -t ipinfo.tw:local .`. Start a local instance with `docker run -d --name ipinfo.tw -p 8080:8080 ipinfo.tw:local`, then watch logs via `docker logs -f ipinfo.tw`. The bundled `docker-compose.yml` targets the published `peterdavehello/ipinfo.tw:latest` image, binding host `127.0.0.1:80` to container port 8080; update that file if you need a compose-based workflow against your local build.

## Coding Style & Naming Conventions

Configuration files use 4-space indentation with extra spacing to align directives and values; keep that alignment when introducing new headers or locations. Attribute values stay double-quoted, and environment variables or header names remain uppercase for consistency. Scripts in `hooks/` follow POSIX sh; avoid bashisms and ensure executable bits are set. When adding files, favor lowercase names with hyphens, matching `ipinfo.conf`.

## Testing Guidelines

The project relies on nginx’s built-in validation and runtime checks. After each build, confirm configuration syntax with `docker run --rm --entrypoint nginx ipinfo.tw:local -t`. Exercise key endpoints from the host to verify GeoLite databases load and headers resolve; adjust the port to match your host mapping:

```sh
curl http://127.0.0.1:8080
curl http://127.0.0.1:8080/json
curl http://127.0.0.1:8080/ip
curl http://127.0.0.1:8080/country
curl http://127.0.0.1:8080/country_code
curl http://127.0.0.1:8080/country_name
curl http://127.0.0.1:8080/as
curl http://127.0.0.1:8080/asn
curl http://127.0.0.1:8080/as_desc
curl http://127.0.0.1:8080/user_agent
curl http://127.0.0.1:8080/build_epoch
```

Capture sample responses in pull requests when behavior changes.

## Commit & Pull Request Guidelines

Commit subjects follow the existing history: capitalize the first word, use the imperative mood, and omit trailing punctuation (e.g. `Update alpine Docker tag to v3.22`). Add a blank line before any body text, wrap at roughly 72 characters, and explain the why. Pull requests should summarize scope, link related issues, and describe validation steps, including commands run and sample endpoint output or screenshots if UI-facing behavior shifts.

## Security & Configuration Tips

Keep `MAXMIND_LICENSE_KEY` out of commits and PR text; rely on environment variables or secret storage. When exposing deployments behind another proxy, document required headers such as `X-Real-IP` in the PR description so reviewers can reproduce the setup safely.

## Key Implementation Notes

Every endpoint is an nginx location block that formats data supplied by the GeoIP2 variables and returns static text or JSON via the `return` directive. The Dockerfile downloads and validates the GeoLite2 databases during the build stage using `MAXMIND_LICENSE_KEY`, so rebuild the image after updating those databases or editing `nginx/conf.d/*.conf`. For DigitalOcean App Platform, use the `DigitalOceanAppPlatform` branch to rely on the `DO-Connecting-IP` header.

## Adding New Endpoints

1. Define any needed variables in `nginx/conf.d/geoip2.conf` or compose existing ones inside `nginx/conf.d/ipinfo.conf`
2. Add the location block and `return` directive in `nginx/conf.d/ipinfo.conf`
3. Rebuild the image and re-run the verification commands above
4. Preserve 4-space indentation and directive alignment to match the existing style
