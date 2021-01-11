#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# checks.sh
# This script stores common checks used throughout scripts in the dotfiles repo
# This file should be sourced, not executed.
# ----------------------------------------------------------------------------------------------------------------------

# cmd_exists: Checks if the passed command is currently valid (installed)
# Arguments:
#     The command to test
# Outputs:
#     0 if the command exists, 1 if it doesnt
# Usage:
#     if cmd_exists brew; then echo "Homebrew is installed"; fi
function cmd_exists() {
    command -v "$1" &> /dev/null

}

# running_as_root: Check if the current script is running using root/sudo
# Arguments:
#     None
# Outputs:
#     0 if root, 1 if not
function running_as_root() {
    [[ $(id -u) == "0" ]] 
}

# running_on_mac: Shorthand way of checking the current operating system
# Arguments:
#     None
# Outputs:
#     0 if on macOS, 1 if not
# Usage:
#     if running_on_mac; then echo "Currently on macOS"; fi
function running_on_mac() {
    [[ "$(uname -s)" == "Darwin" ]]
}

# running_on_linux: Shorthand way of checking the current operating system
# Arguments:
#     None
# Outputs:
#     0 if on Linux, 1 if not
# Usage:
#     if running_on_linux; then echo "Currently on Linux"; fi
function running_on_linux() {
    [[ "$(uname -s)" == "Linux" ]]
}
