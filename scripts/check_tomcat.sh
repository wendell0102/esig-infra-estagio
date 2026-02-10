#!/usr/bin/env bash
set -e

source "$(dirname "$0")/../.env"

SERVICE_NAME=${TOMCAT_SERVICE_NAME:-tomcat}
PID_FILE=${TOMCAT_PID_FILE:-/opt/tomcat/temp/tomcat.pid}

UPTIME="N/A"
STATUS="stopped"

if command -v systemctl &>/dev/null; then
  if systemctl is-active --quiet "$SERVICE_NAME"; then
    STATUS="running"
    PID=$(systemctl show -p MainPID "$SERVICE_NAME" | cut -d= -f2)
    if [ "$PID" != "0" ]; then
      START_TIME=$(ps -p "$PID" -o lstart=)
      UP_SECONDS=$(( $(date +%s) - $(date -d "$START_TIME" +%s) ))
      UPTIME="${UP_SECONDS}s"
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

echo "Tomcat status: ${STATUS}"
echo "Tomcat uptime: ${UPTIME}"
