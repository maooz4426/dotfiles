.PHONY: nix/build nix/check

nix/build/mac:
	sudo nix run nix-darwin -- switch --flake ./nix/flake.nix

nix/build/manix:
	sudo nixos-rebuild switch --flake ./nix#manix

nix/build/wsl:
	nix run nixpkgs#home-manager -- switch -b backup --flake ./nix#maoz@wslnix

nix/check/mac:
	nix build ./nix#darwinConfigurations.MAOZBook.system \
		--no-link --print-build-logs

nix/check/manix:
	nix build ./nix#nixosConfigurations.manix.config.system.build.toplevel \
		--no-link --print-build-logs

nix/check/wsl:
	nix build ./nix#homeConfigurations."maoz@wslnix".activationPackage \
		--no-link --print-build-logs


.PHONY: submodule-init submodule-update

submodule-init:
	git submodule update --init --recursive

submodule-update:
	git submodule update --remote --merge
