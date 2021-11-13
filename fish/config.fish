# Hide the fish welcome message
set -U fish_greeting

set -x DOTS "$HOME/.dotfiles"
set -x EDITOR nvim
set -x GOPATH "$HOME/.go"
set -x STARSHIP_CONFIG "$DOTS/starship/config.toml"
set -x PATH "$DOTS/bin" "/opt/homebrew/bin" "/usr/local/bin" "$PATH" "$GOPATH/bin"

set -l localenv "$HOME/.localenv"
if test -e "$localenv"
    source "$localenv"
end

if type -q gls
    alias ls="gls --group-directories-first --color=auto"
    alias la="ls -A"
    alias ll="ls -l -h"
    alias lla="la -l -h"
end

# Initialize the Starship prompt
starship init fish | source
