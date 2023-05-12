# .dotfiles

## Installation

The installer currently supports both macOS and Linux, but the only Linux distribution I've been able to test it on is Ubuntu. The installer *should* be able to handle installation all on it's own.

```shell
cd ~
git clone https://github.com/cdevoogd/.dotfiles
cd .dotfiles
./install
```


For any machine-specific shell configuration or environment variables, you can add configs to `$XDG_CONFIG_HOME/dots` (default is `~/.config/dots`).
* `$XDG_CONFIG_HOME/dots/profile` should store your environment variables
* `$XDG_CONFIG_HOME/dots/config.fish` should store additional configuration for `fish`,

If you are already running a system with these dotfiles installed, you can edit the local profile with `edit-local-profile` and the local config with `edit-local-config`.
