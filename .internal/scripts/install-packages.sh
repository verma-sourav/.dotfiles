#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORMULAE_BREWFILE="$SCRIPT_DIR/../formulae.Brewfile"
CASKS_BREWFILE="$SCRIPT_DIR/../casks.Brewfile"

source "$SCRIPT_DIR/helpers.sh"

add_brew_to_path() {
    local brew_prefix
    if on_linux; then
        brew_prefix="/home/linuxbrew/.linuxbrew"
    elif on_macos && on_x86; then
        brew_prefix="/usr/local"
    elif on_macos && on_arm; then
        brew_prefix="/opt/homebrew"
    fi

    if [[ -z "$brew_prefix" ]]; then
        logerr "Unsupported OS and architecture combination: $(uname --kernel-name --machine)"
        return 1
    fi

    local brew_bin="$brew_prefix/bin"
    local brew_sbin="$brew_prefix/sbin"
    local brew="$brew_bin/brew"

    if [[ -x "$brew" ]]; then
        logerr "The 'brew' binary does not exist or is not executable at the expected location: $brew"
        return 1
    fi

    export PATH="$brew_bin:$brew_sbin:$PATH"
}

ensure_brew() {
    if  cmd_exists "brew"; then
        log "Homebrew is already installed"
        return
    fi

    # Homebrew needs sudo access on macOS, and I'm assuming there is someone installing the
    # dotfiles that can type in the password, so this is being run interactively.
    log "Homebrew is not installed (or in your PATH) - Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # If we just installed homebrew, it might not be available in the PATH
    add_brew_to_path
}

install_formulae() {
    log "Installing Homebrew formulae..."
    brew bundle install --no-lock --file="$FORMULAE_BREWFILE"
}

install_casks() {
    log "Installing Homebrew casks..."
    brew bundle install --no-lock --file="$CASKS_BREWFILE"
}

install_go_programs() {
    # Go should be installed as a homebrew formula
    go install golang.org/x/tools/cmd/goimports@latest
    go install github.com/cdevoogd/git-branches@latest
}

main() {
    ensure_brew
    install_formulae
    if on_macos; then
        install_casks
    fi
    install_go_programs
}

main "$@"
