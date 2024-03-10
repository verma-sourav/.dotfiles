#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORMULAE_BREWFILE="$SCRIPT_DIR/../formulae.Brewfile"
CASKS_BREWFILE="$SCRIPT_DIR/../casks.Brewfile"

source "$SCRIPT_DIR/helpers.sh"

ensure_brew() {
    if cmd_exists brew; then
        echo "Homebrew is already installed"
        return
    fi

    if ! cmd_exists curl; then
        echo "curl is required as a prerequisite to install homebrew, but it's not installed"
        echo "Please install it using your system's package manager and try again"
        return 1
    fi

    if on_linux; then
        # https://docs.brew.sh/Homebrew-on-Linux#requirements
        log "Installing Homebrew requirements for Linux"
        sudo apt-get update
        sudo apt-get install -y build-essential procps curl file git
    fi

    # Homebrew needs sudo access on macOS, and I'm assuming there is someone installing the
    # dotfiles that can type in the password, so this is being run interactively.
    log "Homebrew is not installed (or in your PATH) - Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_brew_bundle() {
    brew bundle install --no-lock --no-upgrade --file="$1"
}

install_formulae() {
    log "Installing Homebrew formulae..."
    install_brew_bundle "$FORMULAE_BREWFILE"
}

install_casks() {
    if ! on_macos; then
        log "Skipping installation of casks, not on macOS"
        return
    fi

    log "Installing Homebrew casks..."
    install_brew_bundle "$CASKS_BREWFILE"
}

install_go_programs() {
    # Go should be installed as a homebrew formula
    log "Installing Go tools..."
    go install golang.org/x/tools/cmd/goimports@latest
}

main() {
    # The profile should have already been sourced by the install script which should have properly
    # set up PATH and other environment variables. As we install brew and brew formulae, we should
    # be able to access them.
    ensure_brew
    install_formulae
    install_casks
    install_go_programs
}

main "$@"
