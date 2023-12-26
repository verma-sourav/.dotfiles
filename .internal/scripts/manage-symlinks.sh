#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(realpath "$SCRIPT_DIR/../..")"

cleanup_dead_symlinks() {
    echo "Cleaning up dead symlinks in the home directory"
    find -L "$HOME" -maxdepth 1 -type l -print -exec rm -- {} +
    echo "Cleaning up dead symlinks in the ~/.config directory (recursive)"
    find -L "$HOME/.config" -type l -print -exec rm -- {} +
}

create_link() {
    local source="$1"
    local destination="$2"

    if ! [[ -e "$source" ]]; then
        echo "No file exists at source: $source"
        return 1
    fi

    if [[ "$source" -ef "$destination" ]]; then
        echo "Link already exists ($source -> $destination)"
        return
    fi

    if [[ -e "$destination" ]]; then
        echo "A file already exists at the source: $source"
        return 1
    fi

    echo "Creating link: $source -> $destination"
    ln -s "$source" "$destination"
}


main() {
    cleanup_dead_symlinks
    create_link "$REPO_ROOT/espanso/config/default.yml" "$HOME/.config/espanso/config/default.yml"
    create_link "$REPO_ROOT/espanso/match/base.yml" "$HOME/.config/espanso/match/base.yml"
    create_link "$REPO_ROOT/fish/config.fish" "$HOME/.config/fish/config.fish"
    create_link "$REPO_ROOT/fish/functions" "$HOME/.config/fish/functions"
    create_link "$REPO_ROOT/fish/themes" "$HOME/.config/fish/themes"
    create_link "$REPO_ROOT/git/main.gitconfig" "$HOME/.config/git/config"
    create_link "$REPO_ROOT/git/author.gitconfig" "$HOME/.config/git/author.gitconfig"
    create_link "$REPO_ROOT/nvim" "$HOME/.config/nvim"
    create_link "$REPO_ROOT/tmux" "$HOME/.config/tmux"
}

main "$@"
