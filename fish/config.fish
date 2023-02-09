# Hide the fish welcome message
set -U fish_greeting

set -l fish_dotfile_dir (dirname (realpath (status --current-filename)))
set -x DOTS (realpath $fish_dotfile_dir/..)
set -x EDITOR nvim
set -x GOPATH "$HOME/.go"
set -x STARSHIP_CONFIG "$DOTS/starship/config.toml"
set -gx PATH "$DOTS/bin" "/usr/local/go/bin" "$GOPATH/bin" "$PATH"

set -l localenv "$HOME/.localenv"
if test -e "$localenv"
    source "$localenv"
end

alias dots="cd $DOTS"

alias e="$EDITOR"

alias gb="git branches"
alias gs="git status"
alias gc="git commit"

if type -q exa
    alias ls="exa --group-directories-first"
    alias la="exa --group-directories-first --all"
    alias ll="exa --group-directories-first --long"
    alias lla="exa --group-directories-first --long --all"
end

fish_config theme choose catppuccin_mocha
# Initialize the Starship prompt
starship init fish | source
