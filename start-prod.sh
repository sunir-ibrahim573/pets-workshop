#!/bin/bash
set -e

cleanup() {
  if [ -n "$FLASK_PID" ]; then
    kill -TERM "$FLASK_PID" 2>/dev/null || true
  fi
  if [ -n "$ASTRO_PID" ]; then
    kill -TERM "$ASTRO_PID" 2>/dev/null || true
  fi
  wait 2>/dev/null || true
}
trap cleanup SIGINT SIGTERM EXIT

export FLASK_PORT="${FLASK_PORT:-8000}"
export API_SERVER_URL="http://127.0.0.1:${FLASK_PORT}"

cd "$(dirname "$0")/app/server"
python3 app.py &
FLASK_PID=$!

cd ../client
HOST=0.0.0.0 PORT="${PORT:-5000}" node ./dist/server/entry.mjs &
ASTRO_PID=$!

wait -n
