#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$OUT_DIR"
}
trap cleanup EXIT

command -v libime_tabledict >/dev/null || {
  echo "缺少命令: libime_tabledict" >&2
  exit 1
}

libime_tabledict \
  "$ROOT_DIR/tables/tiger.txt" \
  "$OUT_DIR/tiger.main.dict"

echo "OK: $OUT_DIR/tiger.main.dict"
