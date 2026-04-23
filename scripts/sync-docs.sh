#!/bin/bash
# Copies homelab documentation from the docker repo into content/homelab/
# before the Quartz build. Runs as part of the deploy workflow.
set -euo pipefail

DOCKER_REPO="/home/ubuntu/docker"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$SCRIPT_DIR/../content/homelab"

mkdir -p "$DEST"

copy() {
  local src="$DOCKER_REPO/$1"
  local dest="$DEST/$2"
  if [[ -f "$src" ]]; then
    cp "$src" "$dest"
    echo "  synced: $2"
  else
    echo "  MISSING: $1 — skipping"
  fi
}

echo "Syncing homelab docs to content/homelab/..."

copy "SERVICES.md"                          "services.md"
copy "BACKUP.md"                            "backup.md"
copy "networking/traefik/CLAUDE.md"         "traefik.md"
copy "management/homepage/CLAUDE.md"        "homepage.md"
copy "monitoring/grafana/CLAUDE.md"         "grafana.md"
copy "monitoring/telemetry/CLAUDE.md"       "telemetry.md"
copy "automation/n8n/CLAUDE.md"             "n8n.md"
copy "automation/supabase/CLAUDE.md"        "supabase.md"
copy "automation/typebot/CLAUDE.md"         "typebot.md"
copy "automation/directus/CLAUDE.md"        "directus.md"
copy "automation/chatwoot/CLAUDE.md"        "chatwoot.md"
copy "storage/paperless/CLAUDE.md"          "paperless.md"

echo "Done. $(ls "$DEST" | wc -l) files in content/homelab/"
