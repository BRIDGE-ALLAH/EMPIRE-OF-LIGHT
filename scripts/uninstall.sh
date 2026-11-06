#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2024-2026 Temps Contributors
# SPDX-License-Identifier: MIT OR Apache-2.0
#
# Empire of Light Platform — conservative local Compose removal.
# Named volumes, source files, .env and secrets are intentionally preserved.

set -Eeuo pipefail
INSTALL_DIR="${EMPIRE_INSTALL_DIR:-/opt/empire-of-light}"
PROJECT_NAME="${COMPOSE_PROJECT_NAME:-empire-of-light}"
ASSUME_YES=0

RED='' YELLOW='' RESET=''
if [[ -t 1 ]]; then RED=$'\033[0;31m'; YELLOW=$'\033[0;33m'; RESET=$'\033[0m'; fi
fail(){ printf '%serror:%s %s\n' "$RED" "$RESET" "$*" >&2; exit 1; }
usage(){
  cat <<'USAGE'
Empire of Light Platform uninstaller

Usage:
  uninstall.sh [--dir PATH] [--yes]

Stops/removes only this Compose project’s containers and project network.
It does NOT delete named volumes, images, source, .env, or secrets.
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

printf '%s\n' "This will stop and remove containers and the project network for '$PROJECT_NAME'."
printf '%s\n' "Named volumes (database/application data), images, source, .env and secrets will be preserved."
if (( ! ASSUME_YES )); then
  read -r -p "Continue? Type REMOVE to confirm: " answer
  [[ "$answer" == "REMOVE" ]] || { printf '%s\n' "Cancelled. No changes made."; exit 0; }
fi

cd "$INSTALL_DIR"
docker compose -p "$PROJECT_NAME" down
printf '%s\n' "Compose containers and project network removed."
printf '%s\n' "Data and installation files preserved at: $INSTALL_DIR"
printf '%s\n' "To remove the remaining files, back them up and delete the directory manually after verifying your backups."
