#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# install.sh
# This install script installs the homebrew package manager https://brew.sh/
# ----------------------------------------------------------------------------------------------------------------------

set -e
cd "$(dirname "$0")"
source ../scripts/common/checks.sh
source ../scripts/common/logging.sh

function main() {
    if cmd_exists brew; then
    log_warn "Homebrew is already installed."
    exit 0
    fi

    log_info "Installing Homebrew..."
    install_dependencies
    download_homebrew
    install_packages
    log_success "Successfully installed Homebrew!"
}

function install_dependencies() {
    log_info "Installing Homebrew dependencies..."

    if running_on_mac; then
        log_info "Installing Xcode Command Line Tools..."
        xcode select --install
    else
        log_info "Installing build-essential, curl, file, and git..."
        log_warn "This may require you to enter your password."
        sudo apt-get -y update
        sudo apt-get -y upgrade
        sudo apt-get -y install build-essential curl file git
        sudo apt-get -y autoremove
    fi

    log_success "Successfully installed dependencies!"
}

function download_homebrew() {
    log_info "Downloading Homebrew..."

    # Piping echo like this prevents homebrew from requiring the user to press enter.
    echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    # If the script returned an error, stop this script.
    if [[ "${PIPESTATUS[1]}" != 0 ]]
    then
        log_error "Error: Homebrew download script returned a non-zero exit code"
        exit 1
    fi
    source path.zsh

    log_success "Homebrew downloaded successfully"
}

function install_packages() {
    log_info 'Installing Homebrew packages...'

    brew install git
    brew install go
    brew install python3
    brew install wget
    brew install coreutils

    log_success 'Successfully installed Homebrew packages'
}

main "$@"
