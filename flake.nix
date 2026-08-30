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

    # nixvimはNeovimの設定をNixのモジュールとして宣言するフレームワーク
    nixvim.url = "github:nix-community/nixvim";
    # claude-code: Claude Code CLIツール（Nix native binary）
    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # WSL2上でNixOSを動かすためのモジュール
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      nixvim,
      claude-code,
      nixos-wsl,
    }:
    let
      username = "maoz";
      darwinHostname = "MAOZBook";
      darwinSystem = "aarch64-darwin"; # Apple Silicon Mac
      darwinHomedir = "/Users/${username}";
      darwinPkgs = import nixpkgs {
        system = darwinSystem;
        # pkgs.claude-codeをnixpkgs版からclaude-code-nix版に差し替える。
        # claude-code-nixは毎時自動更新するため、nixpkgsより新しい版が手に入る。
        # https://github.com/sadjow/claude-code-nix#using-overlay
        overlays = [ claude-code.overlays.default ];
        # claude-codeはunfreeのため明示的に許可する
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "claude-code" ];
      };

      nixosHostname = "manix";
      nixosSystem = "x86_64-linux";
      nixosHomedir = "/home/${username}";

      wslHostname = "wslnix";
      wslSystem = "x86_64-linux";
      wslHomedir = "/home/${username}";
    in
    {
      darwinConfigurations."${darwinHostname}" = nix-darwin.lib.darwinSystem {
        system = darwinSystem;
        pkgs = darwinPkgs;
        modules = [
          ./profiles/maozbook

          # home-managerをnix-darwinに統合する
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./profiles/maozbook/home.nix;
            home-manager.extraSpecialArgs = {
              inherit nixvim username;
              homedir = darwinHomedir;
            };
          }
        ];

        specialArgs = {
          inherit username;
          homedir = darwinHomedir;
        };
      };

      nixosConfigurations."${nixosHostname}" = nixpkgs.lib.nixosSystem {
        system = nixosSystem;
        modules = [
          ./profiles/nixos

          # home-managerをNixOSに統合する
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./profiles/nixos/home.nix;
            home-manager.extraSpecialArgs = {
              inherit nixvim username;
              homedir = nixosHomedir;
            };
          }
        ];

        specialArgs = {
          inherit claude-code username;
          homedir = nixosHomedir;
        };
      };

      nixosConfigurations."${wslHostname}" = nixpkgs.lib.nixosSystem {
        system = wslSystem;
        modules = [
          nixos-wsl.nixosModules.default
          ./profiles/wsl

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./profiles/wsl/home.nix;
            home-manager.extraSpecialArgs = {
              inherit nixvim username;
              homedir = wslHomedir;
            };
          }
        ];

        specialArgs = {
          inherit claude-code username;
          homedir = wslHomedir;
        };
      };

      homeConfigurations."${username}@${wslHostname}" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = wslSystem;
          # pkgs.claude-codeをclaude-code-nix版に差し替える（理由はflake.nixのdarwinPkgsを参照）
          overlays = [ claude-code.overlays.default ];
          config.allowUnfreePredicate =
            pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
              "claude-code"
              "google-cloud-sdk"
            ];
        };
        modules = [ ./profiles/wsl/home.nix ];
        extraSpecialArgs = {
          inherit nixvim username;
          homedir = wslHomedir;
        };
      };
    };
}
