#!/usr/bin/env bash
#
# Micro
#
# This script installs the micro text editor: https://github.com/zyedidia/micro

function main() {
    if command -v micro &> /dev/null
    then
        say 'Micro is already installed'
        exit 0
    fi

    say 'Installing micro using curl...'
    curl https://getmic.ro | bash
    say 'Moving micro to /usr/bin, your password may be required'
    sudo mv micro /usr/bin
    say 'Successfully installed micro'
}

function say() {
    # Blue
    local color='\033[0;34m'
    local no_color='\033[0m'
    echo -e "${color}${1}${no_color}"
}

main "$@"