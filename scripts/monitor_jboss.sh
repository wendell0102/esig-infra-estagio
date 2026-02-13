#!/usr/bin/env bash
set -e

source "$(dirname "$0")/../.env"

SERVICE_NAME=${JBOSS_SERVICE_NAME:-jboss_esig}
START_CMD=${JBOSS_START_CMD:-"docker start jboss_esig"}
STATE_FILE="/tmp/jboss_down_since"

is_running() {
  # 1) systemd (modo nativo) – não deve bater, mas mantemos compatibilidade
  if command -v systemctl &>/dev/null && systemctl list-units | grep -q "$SERVICE_NAME"; then
    systemctl is-active --quiet "$SERVICE_NAME"
    return $?
  fi

  # 2) Docker (container com esse nome)
  if command -v docker &>/dev/null; then
    if docker ps --format '{{.Names}}' | grep -q "^${SERVICE_NAME}$"; then
      return 0
    fi
  fi

  return 1
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
