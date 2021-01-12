#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# output.sh
# This script stores common logging functions used throughout the dotfiles repository. 
# This file should be sourced, not executed.
# ----------------------------------------------------------------------------------------------------------------------

NOCOLOR='\033[0m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'


# log_question: Write out a question to the user
# Arguments:
#     A string to format
# Outputs:
#     Writes formatted string to stdout
function log_question() {
    local symbol="?"
    echo -e "${LIGHTPURPLE}${symbol} $1${NOCOLOR}"
}

# log_info: Write out an INFO log
# Arguments:
#     A string to format
# Outputs:
#     Writes formatted string to stdout
function log_info() {
    local symbol=">"
    echo -e "${LIGHTBLUE}${symbol} $1${NOCOLOR}"
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
    echo -e "${LIGHTGREEN}${symbol} $1${NOCOLOR}"
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


