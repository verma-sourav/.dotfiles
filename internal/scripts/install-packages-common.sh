#!/usr/bin/env bash
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BASEDIR/helpers.sh"

log "Installing/upgrading starship..."
curl -fsSL https://starship.rs/install.sh | sh -s  -- --yes

go install golang.org/x/tools/cmd/goimports@latest
