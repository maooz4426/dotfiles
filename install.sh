#!/bin/bash

# Neovim
brew install Neovim

# CLI tools
brew install tmux

# Window border decoration
brew install FelixKratz/formulae/borders

# Neovim dependencies (telescope)
brew install ripgrep fd

# Symlink configs
ln -sf "$PWD/nvim" "$HOME/.config/nvim"
ln -sf "$PWD/borders/bordersrc" "$HOME/.config/borders/bordersrc"
