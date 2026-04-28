#!/bin/bash
set -e

cleanup() {
  echo "Shutting down..."
  if [ -n "$FLASK_PID" ]; then
    kill -TERM "$FLASK_PID" 2>/dev/null || true
  fi
  if [ -n "$ASTRO_PID" ]; then
    kill -TERM "$ASTRO_PID" 2>/dev/null || true
  fi
  wait 2>/dev/null || true
}
trap cleanup SIGINT SIGTERM EXIT

export FLASK_PORT=8000
export API_SERVER_URL="http://127.0.0.1:8000"

cd "$(dirname "$0")/app/server"
python3 app.py &
FLASK_PID=$!

cd ../client
npm run dev -- --host 0.0.0.0 --port 5000 &
ASTRO_PID=$!

wait -n
