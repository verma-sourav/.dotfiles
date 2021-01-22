#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# install.sh
# This install script installs neovim
# ----------------------------------------------------------------------------------------------------------------------

set -e
cd "$(dirname "$0")"
source ../scripts/common/checks.sh
source ../scripts/common/logging.sh

function main() {
    log_info "Installing Neovim..."

    install_neovim
    setup_neovim


    log_success "Successfully installed Neovim!"
}

function install_neovim() {
    log_info "Downloading neovim HEAD and luajit HEAD"
    brew install --HEAD luajit
    brew install --HEAD neovim
    log_success "Downloaded neovim and luajit"
}

function setup_neovim() {
    log_info "Setting up neovim..."
    create_dirs
    install_lsp_dependencies
    link_files
    log_success "Finished setting up neovim"
}

function create_dirs() {
    log_info "Creating undo directory"
    mkdir ~/.config/nvim/undo -p
}

function install_lsp_dependencies() {
    log_info "Installing language server dependencies"
    GO111MODULE=off go get golang.org/x/tools/gopls
    GO111MODULE=off go get golang.org/x/tools/cmd/goimports
}

function link_files() {
    log_info "Linking configuration files"
    ln -sf ./nvim/init.vim ~/.config/nvim/init.vim
    ln -sf ./nvim/after ~/.config/nvim/after
}

main "$@"
