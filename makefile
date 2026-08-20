.PHONY: nix/build/mac nix/build/manix nix/build/wsl nix/check/mac nix/check/manix nix/check/wsl

nix/build/mac:
	sudo nix run nix-darwin -- switch --flake .#MAOZBook

nix/build/manix:
	sudo nixos-rebuild switch --flake .#manix

nix/build/wsl:
	nix run nixpkgs#home-manager -- switch -b backup --flake .#maoz@wslnix

nix/check/mac:
	nix build .#darwinConfigurations.MAOZBook.system \
		--no-link --print-build-logs

nix/check/manix:
	nix build .#nixosConfigurations.manix.config.system.build.toplevel \
		--no-link --print-build-logs

nix/check/wsl:
	nix build .#homeConfigurations."maoz@wslnix".activationPackage \
		--no-link --print-build-logs


.PHONY: submodule-init submodule-update

submodule-init:
	git submodule update --init --recursive

submodule-update:
	git submodule update --remote --merge
