#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FISH_CONFIG="$SCRIPT_DIR/../../fish/config.fish"
FORMULAE_BREWFILE="$SCRIPT_DIR/../formulae.Brewfile"
CASKS_BREWFILE="$SCRIPT_DIR/../casks.Brewfile"

source "$SCRIPT_DIR/helpers.sh"

get_brew_path() {
    local brew_prefix
    if on_linux; then
        brew_prefix="/home/linuxbrew/.linuxbrew"
    elif on_macos && on_x86; then
        brew_prefix="/usr/local"
    elif on_macos && on_arm64; then
        brew_prefix="/opt/homebrew"
    fi

    if [[ -z "$brew_prefix" ]]; then
        logerr "Unsupported OS and architecture combination: $(uname --kernel-name --machine)"
        return 1
    fi

    local brew_bin="$brew_prefix/bin"
    local brew_sbin="$brew_prefix/sbin"
    local brew="$brew_bin/brew"

    if ! [[ -x "$brew" ]]; then
        logerr "The 'brew' binary does not exist or is not executable at the expected location: $brew"
        return 1
    fi

    echo "$brew_bin:$brew_sbin"
}

add_brew_to_path() {
    local brew_path
    brew_path="$(get_brew_path)"
    export PATH="$brew_path:$PATH"
}

ensure_brew() {
    # Searching for the binary itself instead of relying on it being present in the PATH just in
    # case it was recently installed but hasn't been added yet. Once the dotfiles are installed
    # and the user switches to the login shell it should be present in the PATH as expected.
    if ! get_brew_path; then
        # Homebrew needs sudo access on macOS, and I'm assuming there is someone installing the
        # dotfiles that can type in the password, so this is being run interactively.
        log "Homebrew is not installed (or in your PATH) - Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        if on_linux; then
            # https://docs.brew.sh/Homebrew-on-Linux#requirements
            log "Installing Homebrew requirements for Linux"
            sudo apt-get update
            sudo apt-get install -y build-essential procps curl file git
        fi
    fi

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
    log "Installing Go tools..."
    # If this is a fresh install, the correct GOPATH from the fish config probably isn't loaded. We
    # are going to need to set it before installing if we want these programs to work when the user
    # logs back in using fish as the login shell (which the dotfile install should set)
    local gopath
    gopath=$(grep "set -x GOPATH" "$FISH_CONFIG" | cut -d' ' -f4 | tr -d '"' | sed "s|\$HOME|$HOME|g")
    export GOPATH="$gopath"

    # Go should be installed as a homebrew formula
    go install golang.org/x/tools/cmd/goimports@latest
    go install github.com/cdevoogd/git-branches@master
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
