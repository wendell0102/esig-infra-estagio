#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/../.env"

SERVICE_NAME=${TOMCAT_SERVICE_NAME:-tomcat_esig}
START_CMD=${TOMCAT_START_CMD:-"docker start tomcat_esig"}
STATE_FILE="/tmp/tomcat_down_since"

is_running() {
  if command -v docker &>/dev/null; then
    docker ps --format '{{.Names}}' | grep -qx "${SERVICE_NAME}"
    return $?
  fi
  return 1
}

if is_running; then
  echo "Tomcat está rodando."
  rm -f "$STATE_FILE"
  exit 0
fi

echo "Tomcat está parado."

NOW=$(date +%s)

if [ ! -f "$STATE_FILE" ]; then
  echo "$NOW" > "$STATE_FILE"
  echo "Marcando momento em que parou."
  exit 0
fi

DOWN_SINCE=$(cat "$STATE_FILE")
ELAPSED=$(( NOW - DOWN_SINCE ))

if [ "$ELAPSED" -gt 60 ]; then
  echo "Parado há mais de 60s. Inicializando Tomcat..."
  eval "$START_CMD"
  rm -f "$STATE_FILE"
else
  echo "Ainda não completou 60s parado (${ELAPSED}s)."
fi
