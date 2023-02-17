#!/usr/bin/env bash
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BASEDIR/helpers.sh"

ensure_brew() {
    if  cmd_exists "brew"; then
        log "Homebrew is already installed"
        return
    fi

    # Homebrew needs sudo access on macOS, and I'm assuming there is someone installing the
    # dotfiles that can type in the password, so this is being run interactively.
    log "Homebrew is not installed (or in your PATH) - Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_formulae() {
    true
}

install_casks() {
    true
}
