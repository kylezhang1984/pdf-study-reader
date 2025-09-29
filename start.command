#!/bin/zsh
set -euo pipefail

# Go to the project directory where this script lives
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd "$SCRIPT_DIR"

# Ensure Node binary can be found when launched by Finder
export PATH="/usr/local/bin:/opt/homebrew/bin:$PATH"

PORT=5173
ROOT_DIR="public"
URL="http://127.0.0.1:${PORT}"
LOG_FILE="/tmp/pdf-reader-http.log"

# 1) Ensure dependencies are available (http-server)
if [ ! -x "./node_modules/.bin/http-server" ]; then
  echo "[start] Installing dependencies..."
  npm install --silent --no-audit --no-fund
fi

# 2) If the port is already in use, try to free it (prior crashed run)
if lsof -ti tcp:${PORT} > /dev/null 2>&1; then
  echo "[start] Port ${PORT} is in use, attempting to stop the previous server..."
  lsof -ti tcp:${PORT} | xargs kill -9 || true
  sleep 1
fi

# 3) Start server in background (so Terminal can close if desired)
#    Serve the 'public' folder as the web root
echo "[start] Launching server at ${URL} (root='${ROOT_DIR}')..."
nohup ./node_modules/.bin/http-server "${ROOT_DIR}" -p ${PORT} -c-1 >"${LOG_FILE}" 2>&1 &
SERVER_PID=$!

echo "[start] Server PID: ${SERVER_PID} (logs: ${LOG_FILE})"

# 4) Wait until server is reachable to avoid 'refused to connect'
printf "[start] Waiting for server to be ready"
for i in {1..60}; do
  if curl -sSf "${URL}" > /dev/null 2>&1; then
    echo " — ready."
    break
  fi
  printf "."; sleep 0.25
  if ! kill -0 ${SERVER_PID} > /dev/null 2>&1; then
    echo "\n[start] Server process exited unexpectedly. See ${LOG_FILE} for details." >&2
    exit 1
  fi
  if [ $i -eq 60 ]; then
    echo "\n[start] Timed out waiting for server. See ${LOG_FILE} for details." >&2
    exit 1
  fi
done

# 5) Open the browser to the site root
if command -v open > /dev/null 2>&1; then
  open "${URL}"
else
  xdg-open "${URL}" > /dev/null 2>&1 || true
fi

echo "[start] Done. You can close this window; the server will keep running in the background."
