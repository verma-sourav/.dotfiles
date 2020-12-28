#!/usr/bin/env bash
#
# Homebrew
#
# This script installs homebrew, as well as a few common programs.

set -e

function main() {
    if command_exists brew &> /dev/null
    then
        say 'Homebrew is already installed.'
    else
        say 'Homebrew is not currently installed.'
        
        # Make sure that the required dependencies are installed
        say 'Installing Homebrew dependencies...'
        install_dependencies
        say 'Successfully installed dependencies'
        
        # Download Homebrew
        say 'Downloading Homebrew...'
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # If the install script returned an error, stop this script.
        if [[ "${PIPESTATUS[0]}" != 0 ]]
        then
            say 'Error: Installation script exited with non-zero code - Homebrew installation aborted'
            exit 1
        fi
        say 'Successfully downloaded Homebrew'

        # Create a path.zsh file to add the brew install to PATH
        say 'Adding Homebrew to PATH...'
        create_path_file
        say 'Successfully added Homebrew to PATH'

        say 'Successfully installed Homebrew'
    fi

    say 'Attempting to install or update common Homebrew packages...'
    install_packages
    say 'Successfully installed/updated Homebrew packages'
    
    exit 0
}

function say() {
    # Blue
    local color='\033[0;34m'
    local no_color='\033[0m'
    echo -e "${color}${1}${no_color}"
}

function command_exists() {
    command -v "$1" 
}

function install_dependencies() {
    if [ "$(uname -s)" == "Darwin" ]
    then
        say 'Installing Xcode Command Line Tools'
        xcode-select --install
    elif [ "$(uname -s)" == "Linux" ]
    then
        say 'This may require you to enter your password.'
        sudo apt-get install curl
    else 
        say 'Error: Unknown operating system - Exiting'
        exit 1
    fi
}

function create_path_file() {
    if [ "$(uname -s)" == "Darwin" ]
    then
        echo 'export PATH="/usr/local/bin:$PATH"' > "$ZSH/homebrew/path.zsh"
    else
        echo 'export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"' > "$ZSH/homebrew/path.zsh"
    fi
    # Since this was just created, we will need to source it for when we install packages.
    source $ZSH/homebrew/path.zsh
}

function install_packages() {
    brew install git python3 wget tree
    brew cleanup
}

main "$@"