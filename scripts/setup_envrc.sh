#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(git rev-parse --show-toplevel)"
REPO_URL="$(git remote get-url origin 2>/dev/null || true)"
if [ -n "$REPO_URL" ]; then
  REPO_NAME="$(basename -s .git "$REPO_URL")"
else
  REPO_NAME="$(basename "$PROJECT_ROOT")"
fi

SOURCE_DIR="$HOME/.envs/$REPO_NAME"

if [ -d "$SOURCE_DIR" ]; then
  # .envrc ファイルのコピー
  if [ -f "$SOURCE_DIR/.envrc" ]; then
    cp "$SOURCE_DIR/.envrc" "$PROJECT_ROOT/.envrc"
    echo "Copied: .envrc"
  fi

  # env/ ディレクトリのコピー
  if [ -d "$SOURCE_DIR/env" ]; then
    if ! command -v rsync >/dev/null 2>&1; then
      echo "error: rsync is required to sync $SOURCE_DIR/env" >&2
      exit 1
    fi
    rsync -a "$SOURCE_DIR/env/" "$PROJECT_ROOT/env/"
    echo "Synced: env/"
  fi
else
  echo "Skipped: $SOURCE_DIR not found"
fi

if [ -f "$PROJECT_ROOT/.envrc" ]; then
  chmod 600 "$PROJECT_ROOT/.envrc"
  echo "Applied: chmod 600 .envrc"
fi

if command -v direnv >/dev/null 2>&1 && [ -f "$PROJECT_ROOT/.envrc" ]; then
  (cd "$PROJECT_ROOT" && direnv allow .)
  echo "Applied: direnv allow ."
fi
