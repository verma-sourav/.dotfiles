# -- Variables -------------------------------------------------------------------------------------
# Dotfiles path shortcut
export DOTS=$HOME/.dotfiles
# Local environment variables location
LOCALENV=~/.localenv

# -- Sourcing --------------------------------------------------------------------------------------
# The location set in the LOCALENV variable above is where you should store
# your local environment variables. This prevents them from being committed
# to the dotfiles git repository.
if [[ -a $LOCALENV ]]
then
    source ~/.localenv
fi

# Get all of our zsh files
# This is currently set to only go one level deep. This prevents the script from loading the
# zsh/plguins directory
typeset -U config_files
config_files=($DOTS/*/*.zsh)

# Load the path files
for file in ${(M)config_files:#*/path.zsh}
do
    source $file
done

# Load everything but the path and completion files
for file in ${${config_files:#*/path.zsh:#*/completion.zsh}}
do
    source $file
done

# Initialize ZSH autocomplete. This needs to be done before functions are loaded.
autoload -U compinit
compinit -d ~/.cache/zsh_compdump

# Load completion files after autocomplete is loads
for file in ${(M)config_files:#*/completion.zsh}
do
    source $file
done

unset config_files

# -- History Configuration -------------------------------------------------------------------------
HISTFILE=~/.cache/zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
