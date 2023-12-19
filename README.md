# dot-files

Cross-platform dotfiles.

## Prerequisites
Install GNU Stow:
```bash
sudo apt stow  # Ubuntu
brew install stow  # Homebrew
```

## *Build*

Run the following to establish the symlinks:
```bash
stow .  # run this within the project root if the project is located in $HOME
stow -d /path/to/project -t ~/  # run this if project located elsewhere
```
