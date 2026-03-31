#!/bin/bash

# Neovim
brew install Neovim

# CLI tools
brew install tmux
brew install tpm

# Window border decoration
brew install FelixKratz/formulae/borders

# Neovim dependencies (telescope)
brew install ripgrep fd

# Symlink configs
ln -sf "$PWD/nvim" "$HOME/.config/nvim"
ln -sf "$PWD/borders/bordersrc" "$HOME/.config/borders/bordersrc"
ln -sf "$PWD/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty"
