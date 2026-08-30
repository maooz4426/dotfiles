# NixOSマシン（manix）用のhome-manager設定。
# macOS専用モジュール（karabiner、ghostty、neovim）は除外する。
{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ../../modules/home
  ];

  home.packages = [
    pkgs.vim
    pkgs.gnumake
    pkgs.mosh
    pkgs.google-cloud-sdk
    pkgs.claude-code
  ];

  programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
      addKeysToAgent = "yes";
    };
  };

  # keychainでssh-agentを起動し、鍵をシェル間で再利用する。
  programs.keychain = {
    enable = true;
    keys = [ "id_ed25519" ];
  };
}
