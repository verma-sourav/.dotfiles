#!/usr/bin/env bash
# This file provides common helper functions that can be sourced in other scripts. Most are pretty
# simple and just help the make things slightly more readable (hopefully).

# Prints a colored message to make it easier to differentate what messages are coming directly from
# the installation scripts.
log() {
    local cyan="\033[0;36m"
    local reset="\033[0m"
    echo -e "${cyan}$1${reset}"
}

# Returns 0 if the given command ($1) is installed/exists.
cmd_exists() {
    command -v "$1" &> /dev/null
}

# Returns 0 if a file exists at the given path ($1) and is a regular file.
file_exists() {
    [ -f "$1" ]
}

# Returns 0 if the script is running on macOS/Darwin.
on_macos() {
    [ "$(uname -s)" == "Darwin" ]
}

# Returns 0 if the script is running on Linux.
on_linux() {
    [ "$(uname -s)" == "Linux" ]
}

# Returns 0 if the given pattern ($1) exists in the file ($2).
pattern_exists() {
    grep -q "$1" "$2"
}
