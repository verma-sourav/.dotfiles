#!/usr/bin/env bash
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$BASEDIR/../Brewfile"

source "$BASEDIR/helpers.sh"

if ! cmd_exists "brew"; then
    log "Homebrew is not installed"
    log "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

log "Installing applications using Homebrew..."
brew bundle install --file="$BREWFILE" --no-lock
