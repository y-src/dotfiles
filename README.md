# dot-files

Cross-platform dotfiles.
Commands shown for Ubuntu and Homebrew, for Windows I use Ubuntu in WSL.

## Prerequisites

### `stow` - for establishing symbolic links

On Ubuntu using APT:
```bash
sudo apt install stow
```

Using Homebrew:
```bash
brew install stow
```

Run the following to establish the symbolic links:
```bash
stow .                          # run this within the project root if the project is located in $HOME
stow -d /path/to/project -t ~/  # run this if project located elsewhere
```

### `gcc`, `unzip`, `wslu`, `pip`  - dependencies required for Ubuntu

On Ubuntu using APT:
```bash
sudo apt update  # to update sources
sudo apt install build-essential  # for gcc, make, etc.
sudo apt instal unzip  # required by `mason.nvim`
sudo apt install python3-pip  # required by `mason.nvim` to install `pyright`, NOTE: `node` (see below) is also required to install `pyright`
sudo apt install wslu  # this are utilities to help the WSL layer interact with Windows
```

### `nvim` - for Neovim

On Ubuntu using APT:
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable # as stable channel may be outdated
sudo apt update
sudo apt install neovim
```

Using Homebrew:
```bash
brew install neovim
```

### `fish` shell and `node-lts`

Instructions to install `fish` are [here](https://fishshell.com/). 

Install `node` using `fisher`:
```bash
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish  # NOTE: possible issues for WSL if node installed on Win32 already 
nvm install lts  # install node LTS
nvm use lts  # activate node
```
Or using Homebrew:
```bash
brew install node
```

### `debugpy` - for the `python` debug adapter

I have configured the DAP to point to the following `debugpy` virtualenv:
```bash
mkdir ~/.virtualenvs
cd ~/.virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

### `llvm` - for the C++ debug adapter

Using Homebrew:
```
brew install llvm
```

On Ubuntu using APT:
```bash
sudo apt install lldb-15
```

I have configured the C++ debugger to point to `lldb-vscode` in `$PATH` via `config.fish`.

## Patched fonts

I use the patched version of JetBrains Mono:

Using Homebrew:
```bash
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
```

Using Scoop (Windows):
```bash
scoop bucket add nerd-fonts
scoop install JetbrainsMono-NF
```

