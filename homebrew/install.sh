#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
    # Only install Homebrew for macOS (I know there is a linux version)
    if test "$(uname)" = "Darwin"
    then
        echo "Installing Homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
    then
        echo "Failed to install Homebrew: Not on macOS"
    fi
fi
exit 0
