# NixOSマシン（manix）用のhome-manager設定。
# macOS専用モジュール（karabiner、ghostty）は除外する。
{
  pkgs,
  config,
  lib,
  nixCats,
  ...
}:
{
  imports = [
    ../../modules/tmux.nix
    ../../modules/neovim.nix
    ../../modules/starship.nix
    ../../modules/zsh.nix
    ../../modules/git.nix
  ];

  home.stateVersion = "25.05";
  home.username = "maoz";
  home.homeDirectory = "/home/maoz";

  home.packages = [
    pkgs.yazi
    pkgs.gcc
    pkgs.clang-tools
    pkgs.lua-language-server
    pkgs.typescript-language-server
    pkgs.gopls
    pkgs.nil
    pkgs.starship
    pkgs.terraform-ls
    pkgs.gitleaks
  ];

  programs.go = {
    enable = true;
  };

  programs.gh = {
    enable = true;
  };
}
