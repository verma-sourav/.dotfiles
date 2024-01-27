# .dotfiles

The installation script supports both macOS and Aptitude-based Linux distributions. I mainly use the installer on macOS and Ubuntu, but it should work on Debian as well. The installer is written in Bash and should be able to handle installation on it's own with minimal dependencies installed prior to running it.

Before running the installer, there are a few packages that you will need to already have installed:
- `git`: Used for cloning the repo and any submodules
- `curl`: Used to download the Homebrew installer
- `sudo`: Needed by the Homebrew installer and for installing some additional packages

Once you have the prerequisites, installation only consists of cloning the repository and then running the `install` command. Currently, it is assumed that the repository is cloned to `~/.dotfiles`.

```shell
cd ~
git clone https://github.com/cdevoogd/.dotfiles
cd .dotfiles
./install
```

You can of course edit any of the config files, but machine-specific shell or environment variable configs are designed to be added to specific config files in `~/.config/dots`.
- `~/.config/dots/profile` should store your environment variables
- `~/.config/dots/config.fish` should store additional configuration for `fish`,

If you are already running a system with these dotfiles installed, you can edit the local profile with `edit-local-profile` and the local config with `edit-local-config`.
