{
    description = "A flake to provision my environment";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, nix-darwin }: let
        hostname = "MAOZBook";
        username = "maoz";
        system = "aarch64-darwin";
        homedir = "/Users/${username}";
        pkgs = import nixpkgs { inherit system; };
    in {
        darwinConfigurations."${hostname}" = nix-darwin.lib.darwinSystem {
            inherit system pkgs;
            modules = [
                ./systems/darwin/default.nix
                home-manager.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.${username} = import ./home/profiles/maozbook/default.nix;
                }
            ];

            specialArgs = { inherit username homedir; };
        };
    };
}
