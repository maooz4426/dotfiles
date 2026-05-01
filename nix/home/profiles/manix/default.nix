# NixOSマシン（manix）用のhome-manager設定。
# macOS専用モジュール（karabiner、ghostty）は除外する。
{
  pkgs,
  config,
  lib,
  nixCats,
  claude-code,
  ...
}:
{
  imports = [
    ../../modules/tmux.nix
    ./zsh.nix
    ../../modules/git.nix
  ];

  home.stateVersion = "25.05";
  home.username = "maoz";
  home.homeDirectory = "/home/maoz";

  home.packages = [
    pkgs.vim
    pkgs.yazi
    pkgs.gcc
    pkgs.gnumake
    pkgs.clang-tools
    pkgs.lua-language-server
    pkgs.typescript-language-server
    pkgs.gopls
    pkgs.nil
    pkgs.terraform-ls
    pkgs.gitleaks
    pkgs.mosh
    pkgs.claude-code
  ];

  nixpkgs.overlays = [ claude-code.overlays.default ];
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
    ];

  programs.go = {
    enable = true;
  };

  programs.gh = {
    enable = true;
  };
}
