if command -v gls &> /dev/null; then
    alias ls="gls --group-directories-first --color=auto"
    alias la="ls -A"
    alias ll="ls -l -h"
    alias lla="la -l -h"
fi

if command -v nvim &> /dev/null; then
    alias vim=nvim
fi

# If we have code oss installed instead of regular vscode, alias it to the regular `code` command
if command -v code-oss &> /dev/null; then
    alias code=code-oss
fi
