# このdotfilesのエントリーポイント。
# nix-darwin（macOSのシステム設定）とhome-manager（ユーザー設定）を組み合わせて
{
    description = "A flake to provision my environment";

    inputs = {
        # パッケージソース（最新の不安定版）
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        # ユーザー環境（~/以下のdotfiles・パッケージ）を管理する
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # macOSのシステム設定（Homebrew・セキュリティ・サービス等）を管理する
        nix-darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # nixCatsはNeovimのプラグイン管理フレームワーク
        nixCats.url = "github:BirdeeHub/nixCats-nvim";
    };

    outputs = { self, nixpkgs, home-manager, nix-darwin, nixCats }: let
        username = "maoz";
        darwinHostname = "MAOZBook";
        darwinSystem = "aarch64-darwin"; # Apple Silicon Mac
        darwinHomedir = "/Users/${username}";
        darwinPkgs = import nixpkgs { system = darwinSystem; };

        nixosHostname = "manix";
        nixosSystem = "x86_64-linux";
        nixosHomedir = "/home/${username}";
        nixosPkgs = import nixpkgs { system = nixosSystem; };
    in {
        darwinConfigurations."${darwinHostname}" = nix-darwin.lib.darwinSystem {
            system = darwinSystem;
            pkgs = darwinPkgs;
            modules = [
                ./systems/darwin/default.nix

                # home-managerをnix-darwinに統合する
                home-manager.darwinModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.${username} = import ./home/profiles/maozbook/default.nix;
                    home-manager.extraSpecialArgs = { inherit nixCats; };
                }
            ];

            specialArgs = { inherit username; homedir = darwinHomedir; };
        };

        nixosConfigurations."${nixosHostname}" = nixpkgs.lib.nixosSystem {
            system = nixosSystem;
            pkgs = nixosPkgs;
            modules = [
                ./systems/nixos/default.nix

                # home-managerをNixOSに統合する
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.${username} = import ./home/profiles/manix/default.nix;
                    home-manager.extraSpecialArgs = { inherit nixCats; };
                }
            ];

            specialArgs = { inherit username; homedir = nixosHomedir; };
        };
    };
}
