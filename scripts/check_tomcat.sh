#!/usr/bin/env bash
set -e

# Carrega variáveis do .env (assumindo que o script está em scripts/)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/../.env"

SERVICE_NAME=${TOMCAT_SERVICE_NAME:-tomcat_esig}

STATUS="stopped"
UPTIME="N/A"

if command -v docker &>/dev/null; then
  # Procura o container pelo nome e pega o RunningFor
  running_for=$(docker ps --format '{{.Names}} {{.RunningFor}}' \
    | awk -v name="$SERVICE_NAME" '$1 == name { $1=""; sub(/^ /,""); print }')

  if [ -n "$running_for" ]; then
    STATUS="running"
    UPTIME="$running_for"
  fi
fi

echo "Tomcat status: ${STATUS}"
echo "Tomcat uptime: ${UPTIME}"
