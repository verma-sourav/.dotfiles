#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# install.sh
# This install script helps to setup features used for git
# ----------------------------------------------------------------------------------------------------------------------

set -e
cd "$(dirname "$0")"
source ../scripts/common/checks.sh
source ../scripts/common/logging.sh

function main() {
    generate_ssh
}

function generate_ssh() {    
    log_question "Do you want to generate an SSH key for GitHub?"
    log_question "Press RETURN to continue or any other key to skip..."
    read -rsN1 char </dev/tty
    if ! [[ "$char" == $'\n' || "$char" == $'\r' ]]; then
        return
    fi

    sleep .5

    local email=$(git config user.email)
    local key_file=~/.ssh/github_ed25519
    local pubkey_file=~/.ssh/github_25519.pub

    log_info "Generating a new SSH key using ed25519..."
    log_info "Using email from git config: $email"
    ssh-keygen -t ed25519 -C $email -f $key_file
    log_success "Successfully generated a new SSH key! (Location: $key_file)"

    log_info "Adding the SSH key to ssh-agent..."
    eval $(ssh-agent -s) > /dev/null
    ssh-add $key_file
    log_success "Successfully added SSH key to ssh-agent!"

    log_info "Adding configuration for GitHub to ~/.ssh/config..."
    printf "Host github.com\n    User git\n    Hostname github.com\n    IdentityFile $key_file" > ~/.ssh/config
    log_success "Successfully added configuration for GitHub!"

    log_warn "Add your public key ($pubkey_file) to your GitHub account: https://github.com/settings/keys"
    log_warn "Update your repositories to use SSH instead of HTTPS: git remote set-url origin git@github.com:USERNAME/REPOSITORY.git"
    log_success "Successfully generated a new SSH key for GitHub!"
}

main "$@"