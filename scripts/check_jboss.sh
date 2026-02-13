#!/usr/bin/env bash
set -e

source "$(dirname "$0")/../.env"

SERVICE_NAME=${JBOSS_SERVICE_NAME:-jboss_esig}

STATUS="stopped"
UPTIME="N/A"

if command -v docker &>/dev/null; then
  if docker ps --format '{{.Names}}' | grep -q "^${SERVICE_NAME}$"; then
    STATUS="running"
    UPTIME=$(docker ps --format '{{.Names}} {{.RunningFor}}' \
      | awk -v name="$SERVICE_NAME" '$1 == name { $1=""; sub(/^ /,""); print }')
  fi
fi

echo "JBoss status: ${STATUS}"
echo "JBoss uptime: ${UPTIME}"
