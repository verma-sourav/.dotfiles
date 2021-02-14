if [[ "$(uname -s)" == "Linux" ]]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
else
    export PATH="/usr/local/bin:$PATH"
fi

export PATH="$DOTS/bin:$PATH"
