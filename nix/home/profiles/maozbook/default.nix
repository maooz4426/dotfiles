# home-manager設定のエントリーポイント。
# 各アプリのモジュールをimportし、共通パッケージをまとめて宣言する。
{
  pkgs,
  config,
  lib,
  nixCats,
  dotfilesDir,
  ...
}:
{
  imports = [
    ../../modules/tmux.nix
    ../../modules/karabiner.nix
    ../../modules/neovim.nix
    ../../modules/starship.nix
    ../../modules/zsh.nix
    ../../modules/ghostty.nix
    ../../modules/git.nix
    ../../modules/claude.nix
  ];

  home.stateVersion = "25.05";
  home.username = "maoz";
  home.homeDirectory = "/Users/maoz";

  home.packages = [
    pkgs.nerd-fonts.hack # Hack Nerd Font
    pkgs.yazi # ターミナルファイルマネージャー
    pkgs.mosh # モバイル向けSSHクライアント
    pkgs.gcc # Cコンパイラ
    pkgs.clang-tools # clangd等のC/C++ツール
    pkgs.lua-language-server # Lua LSP
    pkgs.typescript-language-server # TypeScript LSP
    pkgs.gopls # Go LSP
    pkgs.nil # Nix LSP
    pkgs.starship # シェルプロンプト
    pkgs.mariadb.client # MySQLクライアント（CLIのみ）
    pkgs.terraform-ls
    pkgs.gitleaks
    pkgs.maven # Javaビルドツール
    pkgs.golangci-lint
    pkgs.sops
    pkgs.postgresql  # psqlクライアントCLI（サーバーは含まない）
  ];

  # NixのclangdラッパーがCPLUS_INCLUDE_PATHを汚染する問題を回避するためのclangd設定
  xdg.configFile."clangd/config.yaml".text = ''
    CompileFlags:
      Add:
        - -std=c++17
  '';

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };

  programs.go = {
    enable = true;
  };

  programs.gh = {
    enable = true; # GitHub CLI
  };

}
