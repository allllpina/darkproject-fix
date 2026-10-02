#!/usr/bin/env bash
set -euo pipefail

TARGET_DESKTOP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
DESKTOP_FILE="$TARGET_DESKTOP_DIR/dark-project-lab.desktop"

rm -f "$DESKTOP_FILE"
rm -rf /tmp/dp_web_lab_profile

if command -v update-desktop-database &>/dev/null; then
  update-desktop-database "$TARGET_DESKTOP_DIR" 2>/dev/null || true
fi

echo "Shortcut and temporary files have been deleted."
