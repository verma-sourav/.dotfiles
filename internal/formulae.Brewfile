# Personal tools
tap "cdevoogd/tap"
brew "cdevoogd/tap/notify"
brew "cdevoogd/tap/git-branches"

# Basic tools
brew "git"
brew "less"
brew "python3" unless system "python3 --version > /dev/null"
brew "wget"

# Dotfiles (including scripts in bin) dependencies
brew "fish"
brew "go"
brew "gum"
brew "starship"

# Neovim + plugin dependencies
brew "neovim"
brew "fd"                   # Optional finder dependency for telescope
brew "node"                 # NPM is needed by mason to install tools
brew "ripgrep"              # Suggested dependency for telescope (needed for some grep operations)
brew "shellcheck"           # BashLS should automatically lint with shellcheck when installed
brew "xsel" if OS.linux?    # Linux clipboard support

# Extra nice-to-have tools
brew "bat"
brew "btop"
brew "eza"
brew "fzf"
brew "gh"
brew "glow"
brew "jq"
brew "lazydocker"
brew "lazygit"
brew "yq"
