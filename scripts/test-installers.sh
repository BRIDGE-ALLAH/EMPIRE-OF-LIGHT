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
printf 'PASS: installer/uninstaller syntax, pin validation, and fail-closed CLI smoke tests\n'
