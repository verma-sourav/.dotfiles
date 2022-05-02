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

# Set color scheme
# This is currently set to Ayu Dark, using the config lines printed in the terminal by setting the
# theme from `fish_config`.
set -U fish_color_normal B3B1AD
set -U fish_color_command 39BAE6
set -U fish_color_quote C2D94C
set -U fish_color_redirection FFEE99
set -U fish_color_end F29668
set -U fish_color_error FF3333
set -U fish_color_param B3B1AD
set -U fish_color_comment 626A73
set -U fish_color_match F07178
set -U fish_color_selection --background=E6B450
set -U fish_color_search_match --background=E6B450
set -U fish_color_history_current --bold
set -U fish_color_operator E6B450
set -U fish_color_escape 95E6CB
set -U fish_color_cwd 59C2FF
set -U fish_color_cwd_root red
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 4D5566
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix normal --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

# Initialize the Starship prompt
starship init fish | source
