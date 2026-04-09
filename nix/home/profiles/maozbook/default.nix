# home-manager設定のエントリーポイント。
# 各アプリのモジュールをimportし、共通パッケージをまとめて宣言する。
{pkgs, config, lib, nixCats, ...}: {
    imports = [
        ../../modules/tmux.nix
        ../../modules/karabiner.nix
        ../../modules/neovim.nix
        ../../modules/starship.nix
        ../../modules/zsh.nix
        ../../modules/ghostty.nix
    ];

    home.stateVersion = "25.05";
    home.username = "maoz";
    home.homeDirectory = "/Users/maoz";

    home.packages = [
        pkgs.yazi                      # ターミナルファイルマネージャー
        pkgs.mosh                      # モバイル向けSSHクライアント
        pkgs.gcc                       # Cコンパイラ
        pkgs.clang-tools               # clangd等のC/C++ツール
        pkgs.lua-language-server       # Lua LSP
        pkgs.typescript-language-server # TypeScript LSP
        pkgs.gopls                     # Go LSP
        pkgs.nil                       # Nix LSP
        pkgs.starship                  # シェルプロンプト
        pkgs.mariadb.client            # MySQLクライアント（CLIのみ）
    ];

    programs.go = {
        enable = true;
    };

    programs.gh = {
        enable = true; # GitHub CLI
    };
}
