#!/usr/bin/env bash
set -e

source "$(dirname "$0")/../.env"

SERVICE_NAME=${JBOSS_SERVICE_NAME:-jboss}
PID_FILE=${JBOSS_PID_FILE:-/opt/jboss/standalone/tmp/startup-marker.pid}
START_CMD=${JBOSS_START_CMD:-"/opt/jboss/bin/standalone.sh &"}
STATE_FILE="/tmp/jboss_down_since"

is_running() {
  if command -v systemctl &>/dev/null; then
    systemctl is-active --quiet "$SERVICE_NAME"
    return $?
  elif [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    ps -p "$PID" &>/dev/null
    return $?
  else
    return 1
  fi
}

if is_running; then
  echo "JBoss está rodando."
  rm -f "$STATE_FILE"
  exit 0
fi

echo "JBoss está parado."

NOW=$(date +%s)
if [ ! -f "$STATE_FILE" ]; then
  echo "$NOW" > "$STATE_FILE"
  echo "Marcando momento em que parou."
  exit 0
fi

DOWN_SINCE=$(cat "$STATE_FILE")
ELAPSED=$(( NOW - DOWN_SINCE ))

if [ "$ELAPSED" -gt 60 ]; then
  echo "Parado há mais de 60s. Inicializando JBoss..."
  eval "$START_CMD"
  rm -f "$STATE_FILE"
else
  echo "Ainda não completou 60s parado (${ELAPSED}s)."
fi
