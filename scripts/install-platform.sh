#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2024-2026 Temps Contributors
# SPDX-License-Identifier: MIT OR Apache-2.0
#
# Source-based Compose bootstrap. This is not a signed binary installer.
set -Eeuo pipefail

readonly REPOSITORY="BRIDGE-ALLAH/EMPIRE-OF-LIGHT"
readonly DEFAULT_SOURCE_REF="7a8a20c6d37dbfb06ceb34d2ffc335e6f402ebcf"
readonly DEFAULT_INSTALL_DIR="/opt/empire-of-light"
INSTALL_DIR="${EMPIRE_INSTALL_DIR:-$DEFAULT_INSTALL_DIR}"
SOURCE_REF="${EMPIRE_INSTALL_REF:-$DEFAULT_SOURCE_REF}"
ADMIN_EMAIL="${TEMPS_ADMIN_EMAIL:-}"
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
Platform source installer

Usage:
  install-platform.sh [--dir PATH] [--ref COMMIT_SHA] [--skip-start]

Options:
  --dir PATH       Installation directory (default: /opt/empire-of-light)
  --ref SHA        Exact 40-character source commit (no moving branch names)
  --skip-start     Prepare configuration without starting containers
  -h, --help       Show this help

Environment:
  EMPIRE_INSTALL_DIR   Installation directory
  EMPIRE_INSTALL_REF   Exact source commit SHA
  TEMPS_ADMIN_EMAIL    Initial administrator email (prompted if omitted)

This downloads a pinned source archive; it does not require a local Git clone.
It builds the current Compose stack and is not a signed or production-certified
binary release installer. It does not configure DNS, TLS, a reverse proxy,
firewall policy, or public ingress.
USAGE
}
while (($#)); do
  case "$1" in
    --dir) (($# >= 2)) || fail "--dir requires a path"; INSTALL_DIR=$2; shift 2 ;;
    --ref) (($# >= 2)) || fail "--ref requires a commit SHA"; SOURCE_REF=$2; shift 2 ;;
    --skip-start) SKIP_START=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) fail "Unknown argument: $1 (use --help)" ;;
  esac
done

[[ "$SOURCE_REF" =~ ^[0-9a-fA-F]{40}$ ]] || fail "Source ref must be an exact 40-character commit SHA."
[[ "$(uname -s)" == "Linux" ]] || fail "Supported install target is Linux. No host changes were made."
[[ $EUID -eq 0 ]] || fail "Run as root: sudo bash install-platform.sh"
for cmd in curl tar docker openssl stat sed grep install; do
  command -v "$cmd" >/dev/null 2>&1 || fail "Missing prerequisite: $cmd"
done
docker compose version >/dev/null 2>&1 || fail "Docker Compose v2 plugin is required."
[[ -S /var/run/docker.sock ]] || fail "Docker socket not found. Install/start Docker Engine first."
docker info >/dev/null 2>&1 || fail "Docker daemon is not accessible."
[[ ! -e "$INSTALL_DIR" ]] || fail "Install path already exists: $INSTALL_DIR. Move/backup it yourself; installer will not overwrite existing data."

for name in temps-postgres temps-clickhouse temps-app temps-ingress temps-admin-ingress; do
  if docker ps -a --format '{{.Names}}' | grep -Fxq "$name"; then
    fail "A container named '$name' already exists. Nothing was stopped or removed; resolve the conflict manually."
  fi
done
for name in temps-docker-workloads empire-of-light_temps-network empire-of-light_temps-ingress-network empire-of-light_temps-host-network; do
  if docker network inspect "$name" >/dev/null 2>&1; then
    fail "A Docker network named '$name' already exists. Nothing was changed; review the conflict manually."
  fi
done

info "Platform source bootstrap"
info "Repository: https://github.com/$REPOSITORY"
info "Immutable source commit: $SOURCE_REF"
info "Destination: $INSTALL_DIR"
warn "This builds the repository's current Compose stack; it is not a certified production release."
warn "Review Docker socket access, firewall, network ranges, backups, DNS and TLS before public use."

parent=$(dirname "$INSTALL_DIR")
mkdir -p "$parent"
tmp_dir=$(mktemp -d "$parent/.platform-download.XXXXXX") || fail "Could not create a temporary download directory."
cleanup(){ [[ -z "${tmp_dir:-}" ]] || rm -rf -- "$tmp_dir"; }
trap cleanup EXIT
archive="$tmp_dir/source.tar.gz"
archive_url="https://codeload.github.com/$REPOSITORY/tar.gz/$SOURCE_REF"
curl --proto '=https' --tlsv1.2 --fail --location --silent --show-error --retry 3 "$archive_url" -o "$archive" || fail "Could not download source archive for commit '$SOURCE_REF'."
tar -tzf "$archive" >/dev/null || fail "Downloaded source archive is invalid."
mkdir "$tmp_dir/source"
tar -xzf "$archive" --no-same-owner --no-same-permissions --strip-components=1 -C "$tmp_dir/source" || fail "Could not extract source archive."
rm -f "$archive"
[[ -f "$tmp_dir/source/docker-compose.yml" && -f "$tmp_dir/source/.env.example" ]] || fail "Pinned source is missing required Compose files."
mv "$tmp_dir/source" "$INSTALL_DIR" || fail "Could not move source into $INSTALL_DIR."
rm -rf "$tmp_dir"
tmp_dir=""
trap - EXIT

cd "$INSTALL_DIR"
install -m 600 .env.example .env
mkdir -p -m 700 secrets
if [[ -z "$ADMIN_EMAIL" ]]; then
  read -r -p "Initial administrator email: " ADMIN_EMAIL
fi
[[ "$ADMIN_EMAIL" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]] || fail "A valid administrator email is required."
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
set_env TEMPS_ADMIN_EMAIL "$ADMIN_EMAIL"
set_env TEMPS_ADMIN_PASSWORD_FILE "./secrets/admin_password"
set_env TEMPS_ADMIN_INGRESS_PASSWORD_FILE "./secrets/admin_ingress_password"
printf '%s\n' "$ADMIN_PASSWORD" > secrets/admin_password
printf '%s\n' "$INGRESS_PASSWORD" > secrets/admin_ingress_password
chmod 600 .env secrets/admin_password secrets/admin_ingress_password
chmod 700 secrets

info "Admin email: $ADMIN_EMAIL"
info "Initial admin password (shown once): $ADMIN_PASSWORD"
info "Store this password securely now; it is not recoverable from the installer output."
info "Ingress Basic-auth password (shown once): $INGRESS_PASSWORD"
info "The ingress password is separate from the application admin password."

if ! docker compose -p empire-of-light config --quiet; then
  warn "Compose configuration validation failed. Generated credentials and configuration are preserved at $INSTALL_DIR for diagnosis."
  fail "Review $INSTALL_DIR/.env and the Compose validation error; no containers were started."
fi
ok "Configuration generated and validated."

if ((SKIP_START)); then
  info "Startup skipped. Start later with: cd '$INSTALL_DIR' && docker compose -p empire-of-light up -d --build"
  exit 0
fi

info "Building and starting the Compose stack. First build can take a long time."
if ! docker compose -p empire-of-light up -d --build; then
  warn "Compose startup failed. The installation files and logs are preserved for diagnosis."
  docker compose -p empire-of-light ps || true
  docker compose -p empire-of-light logs --tail=200 || true
  exit 1
fi
docker compose -p empire-of-light ps
info "Inspect logs with: cd '$INSTALL_DIR' && docker compose -p empire-of-light logs --tail=200"
info "Published ports are loopback-bound. Configure a separately reviewed reverse proxy, DNS and TLS before public access."
ok "Compose startup command completed. Confirm service health and readiness before use."
