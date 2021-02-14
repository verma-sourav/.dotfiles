# .dotfiles
This repo is my collection of dotfiles that I use on a daily basis. I like to mess with my dotfiles a lot, and I prefer having a minimal amount of items in my home directory if possible.
Everything inside of the repo is organized by topic, and git submodules are used to keep track of things like ZSH plugins.

## Usage
### Prerequisites
- ZSH
- Git
- Curl

### Installation
```sh
# Make sure you are in your home directory
cd ~
# Clone the repository
git clone https://github.com/cdevoogd/.dotfiles
# Change into the repo directory
cd .dotfiles
# Run the install script
./install
# Dotbot also allows for the --only and --except arguments
# https://github.com/anishathalye/dotbot#command-line-arguments
./install --only link
./install --exclude clean
# etc.
```

For any machine-specific shell configuration or environment variables, use `.localenv`:
```sh
touch ~/.localenv
```

## Special Components
- Anything in the `bin/` directory will be added to your `$PATH` and made available everywhere.
- Any file ending in `.zsh` will be loaded into your environment.
- Any file named `path.zsh` is loaded first and is expected to setup `$PATH` or similar.
- Any file named `completion.zsh` is loaded last and is expected to setup autocomplete.
