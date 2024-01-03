Cross-platform __dotfiles__ for Python and C++ development using `neovim` and `fish`.

Commands shown for Debian-based distributions (via APT) and Homebrew, on Windows I use WSL.

## Table of Contents

- [Prerequisites](#Prerequisites)
- [Python config](#Python-config)
- [C++ config](#Cpp-config)
- [Miscellaneous](#Miscellaneous)

## Prerequisites <a name="Prerequisites" />

### `stow` - for establishing symbolic links

Using Homebrew:
```bash
brew install stow
```

Or using APT:
```bash
sudo apt install stow
```

To establish symbolic links:
- run `stow .` in the `dotfiles` directory if located in `$XDG_CONFIG_HOME`.
- or run `stow -d /path/to/dotfiles -t $XDG_CONFIG_HOME` from anywhere.

### `nvim` - for Neovim

Using Homebrew:
```bash
brew install neovim
```

Or using APT (using unstable channel as stable channel is outdated):
```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

### `fish` shell

Instructions to install `fish` are [here](https://fishshell.com/). 

## Python config <a name="Python-config" />

### `pip`

Using APT:
```bash
sudo apt install python3-pip
```

### `node-lts` - for the `pyright` language server

Install `node` using `fisher`:
```bash
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/nvm.fish 
nvm install lts
nvm use lts
```

Or using Homebrew:
```bash
brew install node
```

### `debugpy` - for the debug adapter

I have configured the DAP to point to the following `debugpy` virtualenv:
```bash
mkdir ~/.virtualenvs
cd ~/.virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
```

## C++ config <a name="Cpp-config" />

### `cmake` and `gcc`

Using APT:
```bash
sudo apt update
sudo apt install build-essential cmake unzip
```

Or using Homebrew:
```bash
brew install gcc cmake cmake-docs
```

### `llvm` - for the debug adapter

Using Homebrew:
```bash
brew install llvm
```

Using APT:
```bash
sudo apt install lldb-15
```

I have configured the C++ debugger to point to `lldb-vscode` in `$PATH` via `config.fish`.

### `cppman` - for manual pages

Using Homebrew:
```bash
brew install cppman
```

Using APT:
```bash
sudo apt-get install cppman
```

## Miscellaneous <a name="Miscellaneous" />

### `wslu` - collection of utilities for WSL

Using APT:
```bash
sudo apt install wslu
```

### `yabai` and `skhd` - Tiling manager and hotkey daemon for macOS

See [`yabai`](https://github.com/koekeishiya/yabai) and [`skhd`](https://github.com/koekeishiya/skhd) for installation instructions.

### Patched fonts

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

<a href="#top">Back to top ⏎</a>
