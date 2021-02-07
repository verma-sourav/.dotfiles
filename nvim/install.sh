#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# install.sh
# This install script installs neovim
# ----------------------------------------------------------------------------------------------------------------------

set -e
cd "$(dirname "$0")"
source ../scripts/common/logging.sh

function main() {
    log_info "Installing Neovim..."
    # neovim is installed in the homebrew installer
    link_files
    log_success "Successfully installed Neovim"
}

function link_files() {
    log_info "Linking configuration files"
    mkdir -p ~/.config/nvim
    ln -svf $ZSH/nvim/init.vim ~/.config/nvim/init.vim
    ln -svf $ZSH/nvim/after ~/.config/nvim/after
    log_success "Linked config files"
}

main "$@"
