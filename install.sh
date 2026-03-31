#!/bin/bash

# Neovim
brew install Neovim

# CLI tools
brew install tmux
brew install tpm
brew install yazi
brew install starship
brew install thefuck
brew install nvm
brew install rbenv
brew install pyenv
brew install mysql-client

# Zsh plugins
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# Languages
brew install go

# Bun (JavaScript runtime)
curl -fsSL https://bun.sh/install | bash

# Window border decoration
brew install FelixKratz/formulae/borders

# Neovim dependencies (telescope)
brew install ripgrep fd

# Ghostty
brew install --cask ghostty

# Symlink configs
ln -sf "$PWD/nvim" "$HOME/.config/nvim"
ln -sf "$PWD/borders/bordersrc" "$HOME/.config/borders/bordersrc"
ln -sf "$PWD/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty"
ln -sf "$PWD/starship" "$HOME/.config/starship"
