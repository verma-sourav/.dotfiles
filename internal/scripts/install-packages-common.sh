#!/usr/bin/env bash
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BASEDIR/helpers.sh"

if ! cmd_exists "starship"; then
    log "Starship prompt is not installed. Installing..."
    curl -fsSL https://starship.rs/install.sh | sh -s  -- --yes
fi

go install golang.org/x/tools/cmd/goimports@latest
