# Using the zsh-git-prompt plugin: https://github.com/zsh-git-prompt/zsh-git-prompt
source $ZSH/zsh/plugins/zsh-git-prompt/zshrc.sh

current_directory() {
    local directory_color=cyan
    local max_displayed_depth=3
    echo -n "%F{$directory_color}%$max_displayed_depth~%f"
}

exit_code() {
    local success_color=green
    local success_symbol='✓'
    local error_color=red
    local error_symbol='✗'
    echo -n "%(?.%F{$success_color}$success_symbol.%F{$error_color}$error_symbol%?)%f"
}

git_status() {
    # This function fixes the following problem:
    # With prompt: '$(current_directory) $(git_status) > '
    #   No repo: ~/fake/directory  > 
    #   In repo: ~/fake/directory [master|...] >
    #   Notice that when not in a repo, there are two spaces between the directory and the '>', but when in a repo its fine.
    # With prompt: '$(current_directory)$(git_status) > '
    #   No repo: ~/fake/directory > 
    #   In repo: ~/fake/directory[master|...] >
    #   Now there is no space on the left when in a repo, and that is ugly.
    git_plugin_status=$(git_super_status)
    if [ $? -eq 255 ]
    then
        echo -n ""
    else
        echo -n "$git_plugin_status "
    fi
}

setopt PROMPT_SUBST
PROMPT='$(exit_code) $(current_directory) $(git_status)> '

