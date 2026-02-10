#!/usr/bin/env bash
set -e

source "$(dirname "$0")/../.env"

SERVICE_NAME=${JBOSS_SERVICE_NAME:-jboss}
PID_FILE=${JBOSS_PID_FILE:-/opt/jboss/standalone/tmp/startup-marker.pid}

UPTIME="N/A"
STATUS="stopped"

if command -v systemctl &>/dev/null; then
  if systemctl is-active --quiet "$SERVICE_NAME"; then
    STATUS="running"
    PID=$(systemctl show -p MainPID "$SERVICE_NAME" | cut -d= -f2)
    if [ "$PID" != "0" ]; then
      START_TIME=$(ps -p "$PID" -o lstart=)
      UP_SECONDS=$(( $(date +%s) - $(date -d "$START_TIME" +%s) ))
      UP_DAYS=$((UP_SECONDS / 86400))
      UP_HOURS=$(( (UP_SECONDS % 86400) / 3600 ))
      UP_MIN=$(( (UP_SECONDS % 3600) / 60 ))
      UP_SEC=$((UP_SECONDS % 60))
      UPTIME="${UP_DAYS}d ${UP_HOURS}h ${UP_MIN}m ${UP_SEC}s"
    fi
  fi
elif [ -f "$PID_FILE" ]; then
  PID=$(cat "$PID_FILE")
  if ps -p "$PID" &>/dev/null; then
    STATUS="running"
    START_TIME=$(ps -p "$PID" -o lstart=)
    UP_SECONDS=$(( $(date +%s) - $(date -d "$START_TIME" +%s) ))
    UPTIME="${UP_SECONDS}s"
  fi
fi

echo "JBoss status: ${STATUS}"
echo "JBoss uptime: ${UPTIME}"
