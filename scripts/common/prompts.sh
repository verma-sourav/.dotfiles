#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# prompts.sh
# This script stores common functions used to send prompts to the user
# ----------------------------------------------------------------------------------------------------------------------
cd "$(dirname "$0")"
source common/logging.sh

# prompt_yes_or_no: Prompt the user with a question and ask for a yes/no response
# Arguments:
#     A string to prompt the user with
# Outputs:
#     Returns 0 if yes, 1 if no
function prompt_yes_or_no() {
    PS3="Answer: "
    log_question "$1"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) return 0;;
            No ) return 1;;
        esac
    done
}

# prompt_for_string: Prompt the user with a question and ask for a string back
# Arguments:
#     A string to prompt the user with
# Outputs:
#     The string that the user input
function prompt_for_string() {
    log_question "$1"
    local response
    read -e -r -p "? > " response
    echo "$response"
}
