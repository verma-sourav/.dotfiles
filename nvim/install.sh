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
    log_success "Successfully installed Neovim"
}

function install_neovim() {
    log_info "Downloading neovim HEAD and luajit HEAD"
    brew install --HEAD luajit
    brew install --HEAD neovim
    log_success "Downloaded neovim and luajit"
}

function setup_neovim() {
    log_info "Setting up neovim..."
#    install_lsp_dependencies
    link_files
    log_success "Finished setting up neovim"
}

# function install_lsp_dependencies() {
#     log_info "Installing language server dependencies"
#     # gopls language server
#     GO111MODULE=off go get -u golang.org/x/tools/gopls
#     # goimports formatter
#     GO111MODULE=off go get -u golang.org/x/tools/cmd/goimports
#     # revive linter
#     GO111MODULE=off go get -u github.com/mgechev/revive
#     # diagnostic-languageserver (used for linters)
#     brew install yarn
#     yarn global add diagnostic-languageserver
#     log_success "Installed LSP dependencies"
# }

function link_files() {
    log_info "Linking configuration files"
    ln -svf $ZSH/nvim/init.vim ~/.config/nvim/init.vim
    ln -svf $ZSH/nvim/after ~/.config/nvim/after
    ln -svf $ZSH/nvim/lua ~/.config/nvim/lua
    log_success "Linked config files"
}

main "$@"
