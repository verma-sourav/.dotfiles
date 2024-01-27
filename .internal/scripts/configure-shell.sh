#!/usr/bin/env bash
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HUSHFILE="$HOME/.hushlogin"

source "$BASEDIR/helpers.sh"

if ! file_exists "$HUSHFILE"; then
    log "Creating a hushlogin file"
    touch "$HUSHFILE"
fi
