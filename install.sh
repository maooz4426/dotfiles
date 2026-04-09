#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
HOSTNAME="${1:-$(scutil --get LocalHostName 2>/dev/null || hostname -s)}"
FLAKE="$DOTFILES_DIR/nix#$HOSTNAME"

echo "Using profile: $HOSTNAME"

# Install Nix (Determinate Systems installer)
if ! command -v nix &>/dev/null; then
    echo "Installing Nix..."
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    # Reload shell environment
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Bootstrap nix-darwin and apply the flake
if ! command -v darwin-rebuild &>/dev/null; then
    echo "Bootstrapping nix-darwin..."
    nix run nix-darwin -- switch --flake "$FLAKE"
else
    echo "Applying nix-darwin configuration..."
    darwin-rebuild switch --flake "$FLAKE"
fi

echo "Done!"
