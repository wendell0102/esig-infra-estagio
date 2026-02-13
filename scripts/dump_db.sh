#!/usr/bin/env bash
set -e

source "$(dirname "$0")/../.env"

echo "Gerando dump do banco ${PG_DATABASE} em ${PG_DUMP_FILE}..."
pg_dump -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -F p -d "$PG_DATABASE" > "$PG_DUMP_FILE"

echo "Dump concluído."
