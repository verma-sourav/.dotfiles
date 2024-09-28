#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(realpath "$SCRIPT_DIR/../..")"

cleanup_dead_symlinks() {
    if [[ -d "$HOME" ]]; then
        echo "Cleaning up dead symlinks in the home directory"
        find -L "$HOME" -maxdepth 1 -type l -print -exec rm -- {} +
    fi
    if [[ -d "$HOME/.config" ]]; then
        echo "Cleaning up dead symlinks in the ~/.config directory (recursive)"
        find -L "$HOME/.config" -type l -print -exec rm -- {} +
    fi
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
        echo "A file already exists at the destination: $destination"
        return 1
    fi

    local destination_dir
    destination_dir="$(dirname "$destination")"
    if ! [[ -d "$destination_dir" ]]; then
        echo "Creating parent directories for link destination: $destination"
        mkdir -p "$destination_dir"
    fi

    echo "Creating link: $source -> $destination"
    ln -s "$source" "$destination"
}


main() {
    cleanup_dead_symlinks
    create_link "$REPO_ROOT/bat" "$HOME/.config/bat"
    create_link "$REPO_ROOT/espanso/config/default.yml" "$HOME/.config/espanso/config/default.yml"
    create_link "$REPO_ROOT/espanso/config/default.yml" "$HOME/.config/espanso/config/default.yml"
    create_link "$REPO_ROOT/espanso/match/base.yml" "$HOME/.config/espanso/match/base.yml"
    create_link "$REPO_ROOT/shell/config.fish" "$HOME/.config/fish/config.fish"
    create_link "$REPO_ROOT/shell/functions" "$HOME/.config/fish/functions"
    create_link "$REPO_ROOT/shell/themes" "$HOME/.config/fish/themes"
    create_link "$REPO_ROOT/git/main.gitconfig" "$HOME/.config/git/config"
    create_link "$REPO_ROOT/git/author.gitconfig" "$HOME/.config/git/author.gitconfig"
    create_link "$REPO_ROOT/nvim" "$HOME/.config/nvim"
    create_link "$REPO_ROOT/starship/config.toml" "$HOME/.config/starship.toml"
    create_link "$REPO_ROOT/tmux" "$HOME/.config/tmux"
    create_link "$REPO_ROOT/wezterm" "$HOME/.config/wezterm"
}

main "$@"
