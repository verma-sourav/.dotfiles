# These variables are from `brew shellenv`
switch (uname)
    case Linux
        set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
        set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew";
    case Darwin
        if test (uname -m) = "x86_64"
            set -gx HOMEBREW_PREFIX "/usr/local";
            set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX/Homebrew";
        else
            set -gx HOMEBREW_PREFIX "/opt/homebrew";
            set -gx HOMEBREW_REPOSITORY "$HOMEBREW_PREFIX";
        end
end

# All other Homebrew variables seem to be the same when based off of the prefix
set -gx HOMEBREW_CELLAR "$HOMEBREW_PREFIX/Cellar";
set -gx PATH "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $PATH;
set -gx MANPATH "$HOMEBREW_PREFIX/share/man" $MANPATH;
set -gx INFOPATH "$HOMEBREW_PREFIX/share/info" $INFOPATH;
