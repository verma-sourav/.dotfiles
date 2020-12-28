#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# output.sh
# This script stores common logging functions used throughout the dotfiles repository. 
# This file should be sourced, not executed.
# ----------------------------------------------------------------------------------------------------------------------

NOCOLOR='\033[0m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTCYAN='\033[1;36m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'

# log_question: Write out a question to the user
# Arguments:
#     A string to format
# Outputs:
#     Writes formatted string to stdout
function log_question() {
    local symbol="?"
    echo -e "${LIGHTCYAN}${symbol} $1${NOCOLOR}"
}

# log_info: Write out an INFO log
# Arguments:
#     A string to format
# Outputs:
#     Writes formatted string to stdout
function log_info() {
    local symbol=">"
    echo -e "${DARKGRAY}${symbol}${NOCOLOR} $1"
}

# log_warn: Write out a WARN log
# Arguments:
#     A string to format
# Outputs:
#     Writes formatted string to stdout
function log_warn() {
    local symbol="!"
    echo -e "${YELLOW}${symbol} $1${NOCOLOR}"
}

# log_success: Write out a SUCCESS log
# Arguments:
#     A string to format
# Outputs:
#     Writes formatted string to stdout
function log_success() {
    local symbol="✓"
    echo -e "${LIGHTGREEN}${symbol}${NOCOLOR} $1"
}

# log_error: Write out an ERROR log
# Arguments:
#     A string to format
# Outputs:
#     Writes formatted string to stderr
function log_error() {
    local symbol="x"
    echo -e "${LIGHTRED}${symbol} $1${NOCOLOR}" >&2
}


