#!/usr/bin/env bash
set -euo pipefail

echo "Installing neovim plugins using the local lockfile"
nvim --headless -c "Lazy! restore" -c "TSUpdateSync" -c "qa"
echo
