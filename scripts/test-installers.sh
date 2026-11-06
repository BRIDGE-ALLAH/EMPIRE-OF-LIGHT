#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2024-2026 Temps Contributors
# SPDX-License-Identifier: MIT OR Apache-2.0
set -Eeuo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALLER="$ROOT/scripts/install-platform.sh"
UNINSTALLER="$ROOT/scripts/uninstall.sh"
fail(){ printf 'FAIL: %s\n' "$*" >&2; exit 1; }

bash -n "$INSTALLER" || fail "installer syntax check failed"
bash -n "$UNINSTALLER" || fail "uninstaller syntax check failed"
bash -n "$0" || fail "test script syntax check failed"

bash "$INSTALLER" --help >/dev/null || fail "installer help failed"
bash "$UNINSTALLER" --help >/dev/null || fail "uninstaller help failed"

if bash "$INSTALLER" --invalid-option >/dev/null 2>&1; then
  fail "installer accepted an unknown option"
fi
if bash "$INSTALLER" --ref main --skip-start >/dev/null 2>&1; then
  fail "installer accepted a moving branch instead of an immutable commit SHA"
fi
if bash "$UNINSTALLER" --invalid-option >/dev/null 2>&1; then
  fail "uninstaller accepted an unknown option"
fi

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT
touch "$tmp_dir/docker-compose.yml"
if bash "$UNINSTALLER" --dir "$tmp_dir" --yes >/dev/null 2>&1; then
  fail "uninstaller accepted a directory without its installation environment file"
fi

# Exercise the actual service-name guard and the down command without requiring
# a Docker daemon. The fake CLI records calls and returns controlled Compose data.
fake_bin="$tmp_dir/bin"
install_dir="$tmp_dir/install"
mkdir -p "$fake_bin" "$install_dir"
touch "$install_dir/docker-compose.yml" "$install_dir/.env"
cat > "$fake_bin/docker" <<'DOCKER'
#!/usr/bin/env bash
set -Eeuo pipefail
printf '%s\n' "$*" >> "$DOCKER_CALLS"
if [[ "$1 $2" == "compose version" || "$1" == "info" ]]; then
  exit 0
fi
if [[ "$1" == "compose" && "$*" == *"config --services"* ]]; then
  printf '%b' "${FAKE_DOCKER_SERVICES:-temps\\npostgres\\nclickhouse\\n}"
  exit 0
fi
if [[ "$1" == "compose" && "$*" == *" down"* ]]; then
  : > "$DOCKER_DOWN_CALLED"
  exit 0
fi
printf 'unexpected fake docker call: %s\n' "$*" >&2
exit 2
DOCKER
chmod +x "$fake_bin/docker"
export PATH="$fake_bin:$PATH"
export DOCKER_CALLS="$tmp_dir/docker-calls"
export DOCKER_DOWN_CALLED="$tmp_dir/docker-down-called"

bash "$UNINSTALLER" --dir "$install_dir" --yes >/dev/null || fail "uninstaller did not accept the expected Compose services"
[[ -f "$DOCKER_DOWN_CALLED" ]] || fail "uninstaller did not call docker compose down"
[[ -f "$install_dir/.env" && -f "$install_dir/docker-compose.yml" ]] || fail "uninstaller removed installation files"

rm -f "$DOCKER_DOWN_CALLED"
: > "$DOCKER_CALLS"
if FAKE_DOCKER_SERVICES=$'temps\npostgres\n' bash "$UNINSTALLER" --dir "$install_dir" --yes >/dev/null 2>&1; then
  fail "uninstaller accepted a Compose project missing clickhouse"
fi
[[ ! -f "$DOCKER_DOWN_CALLED" ]] || fail "uninstaller removed containers after a failed service check"

printf 'PASS: installer/uninstaller syntax, immutable-ref validation, fail-closed guards, and safe Compose removal\n'
