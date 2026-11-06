#!/usr/bin/env bash
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
if bash "$UNINSTALLER" --invalid-option >/dev/null 2>&1; then
  fail "uninstaller accepted an unknown option"
fi
printf 'PASS: installer/uninstaller syntax and CLI smoke tests\n'
