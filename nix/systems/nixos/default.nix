# NixOSシステムレベルの設定。
# ユーザー設定（home-manager）とは異なり、OS全体に影響する設定をここに書く。
{ pkgs, username, ... }:
{
  imports = [
    # マシンのハードウェア設定（nixos-generate-configで生成される）
    # NixOSマシン上で: sudo cp /etc/nixos/hardware-configuration.nix <dotfiles>/nix/systems/nixos/
    ./hardware-configuration.nix
  ];

  # ブートローダー（nixos-generate-configで生成されたhardware-configuration.nixに
  # 既に含まれている場合はここを削除してよい）
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "manix";

  # ロケール・タイムゾーン
  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  # ユーザー設定
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  # Zshをシステムレベルで有効化（home-managerのprograms.zshに必要）
  programs.zsh.enable = true;

  # Nix設定
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "${username}" ];
  };

  # VPNクライアント
  services.tailscale.enable = true;

  system.stateVersion = "25.05";
}
