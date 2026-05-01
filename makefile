.PHONY: nix/build
nix/build/mac:
	sudo nix run nix-darwin -- switch --flake ./nix/flake.nix

nix/build/manix:
	sudo nixos-rebuild switch --flake ./nix#manix
