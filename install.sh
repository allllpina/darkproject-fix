#!/usr/bin/env bash
set -euo pipefail

# Отримуємо абсолютний шлях до кореня репозиторію
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DESKTOP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
DESKTOP_FILE="$TARGET_DESKTOP_DIR/dark-project-lab.desktop"
ICON_PATH="$REPO_DIR/assets/icons/icon-144x144.png"
EXEC_PATH="$REPO_DIR/run.sh"

echo "==> Installing Dark Project Web Lab..."

# Making run.sh executable (just in case)
chmod +x "$EXEC_PATH"

# Creating dedicated directory for .desktop files (just in case)
mkdir -p "$TARGET_DESKTOP_DIR"

# Generating .desktop-файл with real paths
cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=Dark Project Web Lab
Comment=Dark Project Keyboard Configuration Tool
Exec=$EXEC_PATH
Icon=$ICON_PATH
Terminal=false
Categories=Utility;Settings;HardwareSettings;
StartupWMClass=dark-project-lab
EOF

# Updating shortcuts cache
# Оновлюємо кеш ярликів, якщо утиліта присутня в системі
if command -v update-desktop-database &>/dev/null; then
  update-desktop-database "$TARGET_DESKTOP_DIR" 2>/dev/null || true
fi

echo "Done! Shortcut has been created: $DESKTOP_FILE"
echo "Application is available in your вашому Application Launcher."
