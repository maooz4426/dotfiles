.PHONY: nix/flake
nix/flake:
	sudo nix run nix-darwin -- switch --flake ./nix/flake.nix
