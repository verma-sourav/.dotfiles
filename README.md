# .dotfiles

## Installation

### Prerequisites
- Fish
- Git
- Curl

### Steps
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
