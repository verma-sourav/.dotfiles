#!/usr/bin/env bash
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARCH="$(dpkg --print-architecture)"

source "$BASEDIR/helpers.sh"

main() {
    log "Updating the apt repository..."
    sudo apt update

    log "Installing packages using apt..."
    sudo apt install -y \
        "curl" \
        "bat" \
        "exa" \
        "fd-find" \
        "fish" \
        "git" \
        "jq" \
        "less" \
        "python3" \
        "ripgrep" \
        "unzip" \
        "virtualenv" \
        "wget" \
        "xsel"

    log "Installing the GitHub CLI"
    install_gh_cli
    log "Installing Go"
    install_go
    log "Installing Neovim"
    install_neovim
    log "Installing Node.js"
    install_nodejs
}

# Installs the GitHub CLI using apt
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-raspberry-pi-os-apt
install_gh_cli() {
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$ARCH signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
}

# Installs the latest version of Go using the pre-built binaries
# https://go.dev/doc/install
# https://github.com/golang/go/issues/51135#issuecomment-1036043491
install_go() {
    local local_version
    local release_file
    local tempdir
    local version
    version=$(curl --silent "https://go.dev/dl/?mode=json" | jq -r '.[0].version')
    release_file=$(curl --silent "https://go.dev/dl/?mode=json" | jq -r '.[0].files[].filename | select(test("go.*.linux-'"$ARCH"'.tar.gz"))')

    if cmd_exists "go"; then
        local_version="$(go version | cut -d" " -f3)"
        if [[ "$local_version" == "$version" ]]; then
            log "Go is already up-to-date ($version)"
            return 0
        fi
    fi

    log "Installing version: $version"
    tempdir="$(mktemp -d)"
    wget -P "$tempdir" "https://go.dev/dl/$release_file"
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "$tempdir/$release_file"
    rm -rf "$tempdir"
}

# Installs the latest release of neovim
# https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-download
install_neovim() {
    local local_version
    local tempdir
    local version
    local release_file="nvim-linux64.deb"
    local repository="neovim/neovim"
    version=$(latest_release "$repository")

    if cmd_exists "nvim"; then
        local_version="$(nvim --version | head -1 | cut -d" " -f2 | sed -e "s/^v//")"
        if [[ "$local_version" == "$version" ]]; then
            log "Neovim is already up-to-date ($version)"
            return 0
        fi
    fi

    log "Installing version: $version"
    tempdir="$(mktemp -d)"
    wget -P "$tempdir" "https://github.com/$repository/releases/download/$version/$release_file"
    sudo apt install "$tempdir/$release_file"

    rm -rf "$tempdir"
}

# Installs node.js using the pre-built distributions
# https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions
install_nodejs() {
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
    sudo apt-get install -y nodejs
}

# Returns the version of the latest release for a github repo.
# https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
latest_release() {
    curl --silent "https://api.github.com/repos/$1/releases/latest" | jq -r .tag_name
}

main "$@"
