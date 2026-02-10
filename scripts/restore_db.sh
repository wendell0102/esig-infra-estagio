#!/usr/bin/env bash
set -e

source "$(dirname "$0")/../.env"

if [ ! -f "$PG_DUMP_FILE" ]; then
  echo "Arquivo de dump ${PG_DUMP_FILE} não encontrado."
  exit 1
fi

echo "Restaurando banco ${PG_DATABASE} a partir de ${PG_DUMP_FILE}..."
psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" < "$PG_DUMP_FILE"

echo "Restore concluído."
