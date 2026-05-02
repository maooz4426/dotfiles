.PHONY: nix/build nix/check

nix/build/mac:
	sudo nix run nix-darwin -- switch --flake ./nix/flake.nix

nix/build/manix:
	sudo nixos-rebuild switch --flake ./nix#manix

nix/check/mac:
	nix build ./nix#darwinConfigurations.MAOZBook.system \
		--no-link --print-build-logs

nix/check/manix:
	nix build ./nix#nixosConfigurations.manix.config.system.build.toplevel \
		--no-link --print-build-logs
