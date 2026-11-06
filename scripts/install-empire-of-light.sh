#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2024-2026 Temps Contributors
# SPDX-License-Identifier: MIT OR Apache-2.0
#
# Empire of Light Platform — source-based self-host bootstrap.
# This is not a binary/release installer. It builds the repository's Compose
# stack from source and deliberately does not configure public DNS or TLS.

set -Eeuo pipefail

readonly REPO_URL="https://github.com/BRIDGE-ALLAH/EMPIRE-OF-LIGHT"
readonly DEFAULT_INSTALL_DIR="/opt/empire-of-light"
INSTALL_DIR="${EMPIRE_INSTALL_DIR:-$DEFAULT_INSTALL_DIR}"
BRANCH="${EMPIRE_INSTALL_BRANCH:-main}"
SKIP_START=0

RED='' GREEN='' YELLOW='' RESET=''
if [[ -t 1 ]]; then
  RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[0;33m'; RESET=$'\033[0m'
fi
info(){ printf '%s\n' "$*"; }
warn(){ printf '%swarning:%s %s\n' "$YELLOW" "$RESET" "$*" >&2; }
fail(){ printf '%serror:%s %s\n' "$RED" "$RESET" "$*" >&2; exit 1; }
ok(){ printf '%s✓%s %s\n' "$GREEN" "$RESET" "$*"; }

usage(){
  cat <<'USAGE'
Empire of Light Platform installer

Usage:
  install.sh [--dir PATH] [--branch REF] [--skip-start]

Environment:
  EMPIRE_INSTALL_DIR       Installation directory (default: /opt/empire-of-light)
  EMPIRE_INSTALL_BRANCH    GitHub branch to install (default: main)

This installer builds the current source with Docker Compose. It does not
install a prebuilt release, configure DNS/TLS, or expose services publicly.
USAGE
}
while (($#)); do
  case "$1" in
    --dir) (($# >= 2)) || fail "--dir requires a path"; INSTALL_DIR=$2; shift 2 ;;
    --branch) (($# >= 2)) || fail "--branch requires a ref"; BRANCH=$2; shift 2 ;;
    --skip-start) SKIP_START=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) fail "Unknown argument: $1 (use --help)" ;;
  esac
done

[[ "$(uname -s)" == "Linux" ]] || fail "Supported install target is Linux. No host changes were made."
[[ $EUID -eq 0 ]] || fail "Run as root: sudo bash install.sh (or choose a writable --dir and adapt permissions)."
for cmd in git docker openssl; do command -v "$cmd" >/dev/null 2>&1 || fail "Missing prerequisite: $cmd"
done
docker compose version >/dev/null 2>&1 || fail "Docker Compose v2 plugin is required."
[[ -S /var/run/docker.sock ]] || fail "Docker socket not found at /var/run/docker.sock. Install/start Docker Engine first."
docker info >/dev/null 2>&1 || fail "Docker daemon is not accessible. Start Docker and verify permissions."
command -v stat >/dev/null 2>&1 || fail "stat is required."
command -v sed >/dev/null 2>&1 || fail "sed is required."

if [[ -e "$INSTALL_DIR" ]]; then
  fail "Install path already exists: $INSTALL_DIR. Move/backup it yourself; installer will not overwrite existing data."
fi
for name in temps-postgres temps-clickhouse temps-app temps-ingress temps-admin-ingress; do
  if docker ps -a --format '{{.Names}}' | grep -Fxq "$name"; then
    fail "A container named '$name' already exists. Nothing was stopped or removed; resolve the conflict manually."
  fi
done

for name in temps-docker-workloads empire-of-light_temps-network empire-of-light_temps-ingress-network empire-of-light_temps-host-network; do
  if docker network inspect "$name" >/dev/null 2>&1; then
    fail "A Docker network named '$name' already exists. Nothing was changed; review the network conflict manually."
  fi
done

info "Empire of Light Platform — source bootstrap"
info "Repository: $REPO_URL"
info "Ref: $BRANCH"
info "Destination: $INSTALL_DIR"
warn "This builds the current source tree; it is not a certified production release."
warn "Review Docker socket access, firewall, network ranges, backups, DNS and TLS before public use."

[[ "$BRANCH" =~ ^[A-Za-z0-9._/-]+$ && "$BRANCH" != *".."* && "$BRANCH" != /* && "$BRANCH" != */ && "$BRANCH" != *"//"* ]] || fail "Invalid branch name."
parent=$(dirname "$INSTALL_DIR")
mkdir -p "$parent"
tmp_dir=$(mktemp -d "$parent/.empire-of-light-download.XXXXXX") || fail "Could not create a temporary download directory."
cleanup(){ [[ -z "${tmp_dir:-}" ]] || rm -rf -- "$tmp_dir"; }
trap cleanup EXIT
archive="$tmp_dir/source.tar.gz"
archive_url="https://codeload.github.com/BRIDGE-ALLAH/EMPIRE-OF-LIGHT/tar.gz/refs/heads/$BRANCH"
curl --fail --location --silent --show-error --retry 3 "$archive_url" -o "$archive" || fail "Could not download source archive for branch '$BRANCH'."
mkdir "$tmp_dir/source"
tar -xzf "$archive" --strip-components=1 -C "$tmp_dir/source" || fail "Could not extract source archive."
rm -f "$archive"
mv "$tmp_dir/source" "$INSTALL_DIR" || fail "Could not move source into $INSTALL_DIR."
rm -rf "$tmp_dir"
tmp_dir=""
trap - EXIT
cd "$INSTALL_DIR"
[[ -f docker-compose.yml && -f .env.example ]] || fail "Repository checkout is missing docker-compose.yml or .env.example."

install -m 600 .env.example .env
mkdir -p -m 700 secrets
: "${TEMPS_ADMIN_EMAIL:=}"
if [[ -z "${TEMPS_ADMIN_EMAIL}" ]]; then
  read -r -p "Initial administrator email: " TEMPS_ADMIN_EMAIL
fi
[[ "$TEMPS_ADMIN_EMAIL" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]] || fail "A valid administrator email is required."
DOCKER_GID=$(stat -c '%g' /var/run/docker.sock) || fail "Could not determine Docker socket group ID."
POSTGRES_PASSWORD=$(openssl rand -hex 32)
CLICKHOUSE_PASSWORD=$(openssl rand -hex 32)
ADMIN_PASSWORD=$(openssl rand -hex 24)
INGRESS_PASSWORD=$(openssl rand -hex 24)

set_env(){
  local key=$1 value=$2
  if grep -q "^$key=" .env; then
    sed -i "s|^$key=.*|$key=$value|" .env
  else
    printf '%s=%s\n' "$key" "$value" >> .env
  fi
}
set_env POSTGRES_PASSWORD "$POSTGRES_PASSWORD"
set_env CLICKHOUSE_PASSWORD "$CLICKHOUSE_PASSWORD"
set_env DOCKER_GID "$DOCKER_GID"
set_env TEMPS_ADMIN_EMAIL "$TEMPS_ADMIN_EMAIL"
set_env TEMPS_ADMIN_PASSWORD_FILE "./secrets/admin_password"
set_env TEMPS_ADMIN_INGRESS_PASSWORD_FILE "./secrets/admin_ingress_password"
printf '%s\n' "$ADMIN_PASSWORD" > secrets/admin_password
printf '%s\n' "$INGRESS_PASSWORD" > secrets/admin_ingress_password
chmod 600 .env
chmod 700 secrets
chmod 444 secrets/admin_password secrets/admin_ingress_password

docker compose -p empire-of-light config --quiet || fail "Compose configuration validation failed. Review $INSTALL_DIR/.env; no containers were started."
ok "Configuration generated and validated."
info "Admin email: $TEMPS_ADMIN_EMAIL"
info "Initial admin password (shown once): $ADMIN_PASSWORD"
info "Store this password securely now. It is not recoverable from the installer output."
info "Ingress Basic-auth password (shown once): $INGRESS_PASSWORD"
info "The ingress password is separate from the application admin password."

if ((SKIP_START)); then
  info "Skipped startup by request. Start later with: cd '$INSTALL_DIR' && docker compose -p empire-of-light up -d --build"
  exit 0
fi

info "Building and starting the Compose stack. This can take a long time on first run."
docker compose -p empire-of-light up -d --build
docker compose -p empire-of-light ps
info "Next: inspect logs with: cd '$INSTALL_DIR' && docker compose -p empire-of-light logs --tail=200"
info "Published Compose ports are loopback-bound. Configure a separately reviewed reverse proxy, DNS and TLS before public access."
ok "Source bootstrap completed. Production readiness is not certified by this installer."
