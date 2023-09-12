set fish_dotfiles_dir (dirname (realpath (status --current-filename)))

set -U fish_greeting
set fish_function_path $fish_function_path "$fish_dotfiles_dir/plugins/fenv/functions"
fish_config theme choose catppuccin_mocha

# Sourcing the profile in the dotfiles repository to make sure we are always loading the right one
set profile "$fish_dotfiles_dir/profile"
if test -f "$profile"
    fenv source "$profile"
end

if test -f "$DOTS_LOCAL_CONFIG"
    source "$DOTS_LOCAL_CONFIG"
end

alias e="$EDITOR"
alias dots="cd $DOTS"

alias gb="git branches"
alias gs="git ss"
alias gc="git commit"

if type -q eza
    alias ls="eza --group-directories-first"
    alias la="eza --group-directories-first --all"
    alias ll="eza --group-directories-first --long"
    alias lla="eza --group-directories-first --long --all"
end

ensure_ssh_agent
starship init fish | source
