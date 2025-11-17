#!/usr/bin/env bash
set -euo pipefail

# -----------------------------
# Config
# -----------------------------
TEMPLATE_NAME="zshrc.template"
TARGET_ZSHRC="$HOME/.zshrc"

# -----------------------------
# Find the directory of this script
# -----------------------------
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_PATH="$SCRIPT_DIR/$TEMPLATE_NAME"

if [[ ! -f "$TEMPLATE_PATH" ]]; then
  echo "Template not found at: $TEMPLATE_PATH" >&2
  exit 1
fi

# -----------------------------
# Backup existing ~/.zshrc if it exists
# -----------------------------
timestamp="$(date +"%Y%m%d-%H%M%S")"
if [[ -f "$TARGET_ZSHRC" ]]; then
  backup_path="${TARGET_ZSHRC}.backup-${timestamp}"
  cp "$TARGET_ZSHRC" "$backup_path"
  echo "Backed up existing .zshrc to: $backup_path"
fi

# -----------------------------
# Write new ~/.zshrc from template
# -----------------------------
tmpfile="$(mktemp)"
cp "$TEMPLATE_PATH" "$tmpfile"

mv "$tmpfile" "$TARGET_ZSHRC"
echo "New .zshrc written to: $TARGET_ZSHRC"

echo
echo "Done ✅"
echo "Open a new terminal or run:  source ~/.zshrc"
