#!/usr/bin/env bash
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FISH_BIN=$(command -v fish)
SHELLS_FILE="/etc/shells"
HUSHFILE="$HOME/.hushlogin"

source "$BASEDIR/helpers.sh"

if ! pattern_exists "$FISH_BIN" "$SHELLS_FILE"; then
    log "Adding fish ($FISH_BIN) to the list of allowed shells"
    sudo sh -c "echo $FISH_BIN >> $SHELLS_FILE"
fi

if ! file_exists "$HUSHFILE"; then
    log "Creating a hushlogin file"
    touch "$HUSHFILE"
fi
