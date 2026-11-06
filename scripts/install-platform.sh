#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2024-2026 Temps Contributors
# SPDX-License-Identifier: MIT OR Apache-2.0
#
# Source-based Compose bootstrap. This is not a signed binary installer.
set -Eeuo pipefail

readonly REPOSITORY="BRIDGE-ALLAH/EMPIRE-OF-LIGHT"
readonly DEFAULT_SOURCE_REF="7ba73b5745f5a86294d0d375468ee3b72c80d40e"
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
# Prepare a clean Ubuntu/Debian VPS automatically. Existing Docker installations
# are never replaced or reconfigured; if Compose v2 is missing, stop safely.
[[ -r /etc/os-release ]] || fail "Cannot identify Linux distribution."
. /etc/os-release
case "${ID:-}" in
  ubuntu|debian) ;;
  *) fail "Automatic host setup supports Ubuntu and Debian only (detected: ${ID:-unknown})." ;;
esac
command -v apt-get >/dev/null 2>&1 || fail "apt-get is required for VPS prerequisite setup."
if ! command -v curl >/dev/null 2>&1 || ! command -v tar >/dev/null 2>&1 || ! command -v openssl >/dev/null 2>&1; then
  info "Installing required host utilities..."
  apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl tar openssl coreutils sed grep
fi
if ! command -v docker >/dev/null 2>&1; then
  info "Installing Docker Engine and Compose v2 from the official Docker repository..."
  DEBIAN_FRONTEND=noninteractive apt-get install -y ca-certificates curl gnupg
  install -m 0755 -d /etc/apt/keyrings
  curl --proto '=https' --tlsv1.2 --fail --location --silent --show-error https://download.docker.com/linux/"$ID"/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc
  docker_arch=$(dpkg --print-architecture)
  docker_codename="${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}"
  [[ -n "$docker_codename" ]] || fail "Could not determine the distribution codename."
  printf 'deb [arch=%s signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/%s %s stable\\n' "$docker_arch" "$ID" "$docker_codename" > /etc/apt/sources.list.d/docker.list
  apt-get update
  DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  systemctl enable --now docker
fi
for cmd in curl tar docker openssl stat sed grep install; do
  command -v "$cmd" >/dev/null 2>&1 || fail "Missing prerequisite after setup: $cmd"
done
docker compose version >/dev/null 2>&1 || fail "Docker is present but Compose v2 is missing. Install the Docker Compose plugin manually; existing Docker was left untouched."
[[ -S /var/run/docker.sock ]] || fail "Docker socket not found. Start Docker Engine first."
docker info >/dev/null 2>&1 || {
  command -v systemctl >/dev/null 2>&1 && systemctl enable --now docker || true
  docker info >/dev/null 2>&1 || fail "Docker daemon is not accessible."
}
mem_gib=$(awk '/MemTotal:/ {printf "%d", $2/1024/1024}' /proc/meminfo)
disk_gib=$(df -Pk "$(dirname "$INSTALL_DIR")" 2>/dev/null | awk 'NR==2 {printf "%d", $4/1024/1024}')
cpu_count=$(getconf _NPROCESSORS_ONLN 2>/dev/null || printf '1')
(( mem_gib >= 8 )) || warn "VPS has ${mem_gib} GiB RAM; 8 GiB or more is recommended for source builds."
(( disk_gib >= 40 )) || warn "VPS has ${disk_gib} GiB free; at least 40 GiB is recommended for image builds and persistent data."
(( cpu_count >= 4 )) || warn "VPS has ${cpu_count} CPU cores; 4 or more are recommended."
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
info "Waiting for database, application, and ingress health checks (up to 10 minutes)..."
health_deadline=$((SECONDS + 600))
required_containers=(temps-postgres temps-clickhouse temps-app temps-ingress temps-admin-ingress)
while (( SECONDS < health_deadline )); do
  all_healthy=1
  for container in "${required_containers[@]}"; do
    state=$(docker inspect --format '{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}' "$container" 2>/dev/null || printf 'missing')
    [[ "$state" == "healthy" ]] || all_healthy=0
  done
  (( all_healthy )) && break
  sleep 5
done
if (( ! all_healthy )); then
  warn "One or more required services did not become healthy. Installation files and volumes are preserved."
  docker compose -p empire-of-light ps || true
  docker compose -p empire-of-light logs --tail=200 || true
  fail "VPS deployment did not pass the service health gate."
fi
info "Inspect logs with: cd '$INSTALL_DIR' && docker compose -p empire-of-light logs --tail=200"
info "Published ports are loopback-bound. Public DNS/HTTPS reverse proxy setup remains a separate step."
ok "All required Compose services report healthy."
