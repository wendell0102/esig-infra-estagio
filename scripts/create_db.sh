#!/usr/bin/env bash
set -e

# Carrega variáveis do arquivo .env
source "$(dirname "$0")/../.env"

echo "Criando banco de dados ${PG_DATABASE} (se não existir)..."
createdb -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" "$PG_DATABASE" 2>/dev/null || echo "Banco já existe."

echo "Criando tabela de exemplo..."
psql -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" -f "$(dirname "$0")/../sql/init.sql"

echo "Banco e tabela de exemplo prontos."
