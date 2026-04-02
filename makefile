.PHONY: nix/build
nix/build:
	sudo nix run nix-darwin -- switch --flake ./nix/flake.nix
