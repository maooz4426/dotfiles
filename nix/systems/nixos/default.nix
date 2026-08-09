# NixOSシステムレベルの設定。
# ユーザー設定（home-manager）とは異なり、OS全体に影響する設定をここに書く。
{
  pkgs,
  lib,
  modulesPath,
  username,
  ...
}:
{
  imports = [
    # Proxmox LXC用の設定（boot.isContainer・/sbin/init・systemd-networkd連携）。
    # LXCはホストのカーネルを使うのでhardware-configuration.nixは不要。
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  # ホスト名をNix側で管理する。falseのままだとhostNameがmkForce ""され、
  # Proxmoxが/etc/hostnameへ書く値を使う動作になる。
  proxmoxLXC.manageHostName = true;

  networking.hostName = "manix";

  # ロケール・タイムゾーン
  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  # ユーザー設定
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzwLxS2xOWY339fHI0EDGJ3baoZ5p9MT93+7bgi1qN+ moshi"
    ];
  };

  # Zshをシステムレベルで有効化（home-managerのprograms.zshに必要）
  programs.zsh.enable = true;

  # SSH鍵認証のみで運用するため、wheelグループのsudoパスワードは不要にする
  # （宣言的ユーザー管理ではhashedPasswordを設定しない限りアカウントがロックされ、sudoが詰まるため）
  security.sudo.wheelNeedsPassword = false;

  # Nix設定
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

  # Mosh (UDP)
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 60000;
      to = 61000;
    }
  ];

  # SSH
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "yes";
  };

  # VPNクライアント
  services.tailscale.enable = true;
  # Tailscale経由のトラフィックを許可する
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.checkReversePath = "loose";

  # unfreeパッケージの許可
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
      "google-cloud-sdk"
    ];

  fonts.packages = [ pkgs.nerd-fonts.hack ];

  system.stateVersion = "25.05";
}
