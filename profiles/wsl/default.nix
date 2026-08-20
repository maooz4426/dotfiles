# WSL2上のNixOSシステム設定。
# manixと異なりブートローダーとhardware-configurationは不要。
{ pkgs, lib, username, ... }:
{
  wsl.enable = true;
  wsl.defaultUser = username;

  networking.hostName = "wslnix";

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "${username}"
    ];
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
      "google-cloud-sdk"
    ];

  system.stateVersion = "25.05";
}
