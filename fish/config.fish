# Hide the fish welcome message
set -U fish_greeting

set -x DOTS "$HOME/.dotfiles"
set -x EDITOR nvim
set -x GOPATH "$HOME/.go"
set -x STARSHIP_CONFIG "$DOTS/starship/config.toml"
set -x PATH "$DOTS/bin" "/opt/homebrew/bin" "/usr/local/go/bin" "/usr/local/bin" "$PATH" "$GOPATH/bin"

set -l localenv "$HOME/.localenv"
if test -e "$localenv"
    source "$localenv"
end

alias dots="cd $DOTS"

alias gb="git branches"
alias gs="git status"
alias gc="git commit"

if type -q exa
    alias ls="exa --group-directories-first"
    alias la="exa --group-directories-first --all"
    alias ll="exa --group-directories-first --long"
    alias lla="exa --group-directories-first --long --all"
end

# name: 'Catppuccin mocha'
# url: 'https://github.com/catppuccin/fish'
# preferred_background: 1e1e2e
set -U fish_color_normal cdd6f4
set -U fish_color_command 89b4fa
set -U fish_color_param f2cdcd
set -U fish_color_keyword f38ba8
set -U fish_color_quote a6e3a1
set -U fish_color_redirection f5c2e7
set -U fish_color_end fab387
set -U fish_color_error f38ba8
set -U fish_color_gray 6c7086
set -U fish_color_selection --background=313244
set -U fish_color_search_match --background=313244
set -U fish_color_operator f5c2e7
set -U fish_color_escape f2cdcd
set -U fish_color_autosuggestion 6c7086
set -U fish_color_cancel f38ba8
set -U fish_color_cwd f9e2af
set -U fish_color_user 94e2d5
set -U fish_color_host 89b4fa
set -U fish_pager_color_progress 6c7086
set -U fish_pager_color_prefix f5c2e7
set -U fish_pager_color_completion cdd6f4
set -U fish_pager_color_description 6c7086

# Initialize the Starship prompt
starship init fish | source
