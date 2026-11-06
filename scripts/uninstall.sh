#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2024-2026 Temps Contributors
# SPDX-License-Identifier: MIT OR Apache-2.0
#
# Conservative Compose removal. Persistent data and credentials are preserved.
set -Eeuo pipefail

INSTALL_DIR="${EMPIRE_INSTALL_DIR:-/opt/empire-of-light}"
PROJECT_NAME="${COMPOSE_PROJECT_NAME:-empire-of-light}"
ASSUME_YES=0

RED='' RESET=''
if [[ -t 1 ]]; then RED=$'\033[0;31m'; RESET=$'\033[0m'; fi
fail(){ printf '%serror:%s %s\n' "$RED" "$RESET" "$*" >&2; exit 1; }
usage(){
  cat <<'USAGE'
Platform Compose uninstaller

Usage:
  uninstall.sh [--dir PATH] [--yes]

Stops/removes only the selected Compose project's containers and networks.
It preserves named volumes, images, source, .env, and secret files.
There is deliberately no automatic data-wipe option.
USAGE
}
while (($#)); do
  case "$1" in
    --dir) (($# >= 2)) || fail "--dir requires a path"; INSTALL_DIR=$2; shift 2 ;;
    --yes) ASSUME_YES=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) fail "Unknown argument: $1 (use --help)" ;;
  esac
done

[[ -d "$INSTALL_DIR" ]] || fail "Install directory not found: $INSTALL_DIR"
[[ -f "$INSTALL_DIR/docker-compose.yml" ]] || fail "No docker-compose.yml found in $INSTALL_DIR"
command -v docker >/dev/null 2>&1 || fail "Docker is required."
docker compose version >/dev/null 2>&1 || fail "Docker Compose v2 plugin is required."
docker info >/dev/null 2>&1 || fail "Docker daemon is not accessible."

printf '%s\n' "This will stop and remove containers and project networks for '$PROJECT_NAME'."
printf '%s\n' "Named volumes, images, source, .env, and secrets will be preserved."
if (( ! ASSUME_YES )); then
  read -r -p "Continue? Type REMOVE to confirm: " answer
  [[ "$answer" == "REMOVE" ]] || { printf '%s\n' "Cancelled. No changes made."; exit 0; }
fi

cd "$INSTALL_DIR"
docker compose -p "$PROJECT_NAME" down
printf '%s\n' "Compose containers and project networks removed."
printf '%s\n' "Persistent data and installation files preserved at: $INSTALL_DIR"
printf '%s\n' "After verifying backups, remove remaining files manually if desired."
