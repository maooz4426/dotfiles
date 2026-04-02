{
    description = "A flake to provision my environment";

    inputs = {
        nixpkgs = {
            url = "github:nixos/nixpkgs?ref=nixos-unstable";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        home-manager,
        nix-darwin,
    }: {
        darwinConfigurations = {
            "macbook" = nix-darwin.lib.darwinSystem {
                # x86 macOS 使ってる場合は、"x86_64-darwin" を指定する
                system = "aarch64-darwin";

                modules = [
                    {
                        system = {
                            stateVersion = 5;
                        };
                    }
                    home-manager.darwinModules.home-manager
                ];
            };
        };
    };
}
