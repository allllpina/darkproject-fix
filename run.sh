#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT=8042
PROFILE_DIR="/tmp/dp_web_lab_profile"

# Запускаємо сервер у тій же папці, де лежить скрипт
python -m http.server "$PORT" --directory "$DIR" &
SERVER_PID=$!

# При будь-якому виході або закритті вікна — глушимо сервер
trap 'kill "$SERVER_PID" 2>/dev/null || true' EXIT

sleep 0.4

# Окремий user-data-dir блокує процес у bash до закриття вікна
google-chrome-stable \
  --app="http://localhost:$PORT/index.html" \
  --class="dark-project-lab" \
  --user-data-dir="$PROFILE_DIR" \
  --no-first-run \
  --no-default-browser-check
