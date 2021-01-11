# Tilde
Tilde is my collection of dotfiles and configuration files for my systems. This repository is based off of [holman/dotfiles](https://github.com/holman/dotfiles).

I mess with my dotfiles a lot, and I prefer having a minimal amount of items in my home directory. Holman's approach to dotfiles solved a lot of my problems, and I
think that is creates a really nice setup for clean, organized, dotfiles repo.

Everything inside of the repo is organized by topic, and git submodules are used to keep track of things like ZSH plugins.

## Usage
### Prerequisites
- ZSH
- Git
- Curl

### Installation
```sh
# CLone the repository to the .dotfiles directory
git clone https://github.com/cdevoogd/tilde.git ~/.dotfiles
# Change into the new directory
cd .dotfiles
# Run bootstrap to install the dotfiles
scripts/bootstrap
# Rerun ZSH to make sure we are using the newly-installed dotfiles
zsh
# Run the install scripts
scripts/install
```

You may want to change the `zsh/zshrc.symlink` file. This file sets up a few paths that will be different on your particular machine.

For local changes and environment variables, you can create a file inside of your home directory named `.localenv`. This file will be automatically sourced by zsh.

## Special Components
#### `bin/`
Anything in the `bin/` directory will be added to your `$PATH` and made available everywhere.

#### `topic/symlink.*`
Any file beginning with `symlink.` will be symlinked into your `$HOME`. This is so you can have your autoloaded files in your home directory, but keep the other files 
inside of your dotfiles directory. These files will be symlinked when you run `scripts/bootstrap`.

#### `topic/*.zsh`
Any file ending in `.zsh` will be loaded into your environment.

#### `topic/path.zsh`
Any file named `path.zsh` is loaded first and is expected to setup `$PATH` or similar.

#### `topic/completion.zsh`
Any file named `completion.zsh` is loaded last and is expected to setup autocomplete.

#### `topic/install.sh`
Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh` and not `.zsh`.

