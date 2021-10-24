export DOTS="$HOME/.dotfiles"
export EDITOR='nvim'
export GOPATH="$HOME/.go"
export STARSHIP_CONFIG="$DOTS/zsh/prompt.toml"

# Set up custom paths
DOTFILES_BIN="$DOTS/bin"
LOCAL_BIN="/usr/local/bin"
GO_BIN="$GOPATH/bin"
export PATH="$DOTFILES_BIN:$LOCAL_BIN:$PATH:$GO_BIN"

# Load .localenv if it exists (file for machine-specific or sensitive environment variables)
export LOCALENV="$HOME/.localenv"
if [[ -a $LOCALENV ]]; then
    source "$LOCALENV"
fi

# Set up ZSH history management (I don't want the file in my home...)
HISTFILE="$HOME/.cache/zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# Set up ZSH completion
autoload -U compinit
compinit -d ~/.cache/zsh_compdump
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case-insensitive matching for lowercase
zstyle ':completion:*' insert-tab pending           # Pasting with tabs doesn't perform completion

# Load plugins
source "$DOTS/submodules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$DOTS/submodules/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Load prompt (Starship should be downloaded when the install script is ran)
eval "$(starship init zsh)"

# Custom aliases
if command -v gls &> /dev/null; then
    alias ls="gls --group-directories-first --color=auto"
    alias la="ls -A"
    alias ll="ls -l -h"
    alias lla="la -l -h"
fi

if command -v nvim &> /dev/null; then
    alias vim=nvim
fi
