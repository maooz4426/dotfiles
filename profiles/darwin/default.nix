# macOSシステムレベルの設定。nix-darwinで管理する。
# ユーザー設定（home-manager）とは異なり、OS全体に影響する設定をここに書く。
{ username, homedir, ... }:
{
  imports = [
    ../../modules/darwin/borders.nix
  ];

  # nix-darwinのnix管理を無効化（Determinate Nixを使用しているため）
  nix.enable = false;

  system.stateVersion = 5;
  system.primaryUser = username;

  users.users.${username}.home = homedir;

  # sudoでTouch IDを使えるようにする
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    reattach = true; # tmux内でも動作するように必要
  };

  # VPNクライアント
  # https://nix-darwin.github.io/nix-darwin/manual/#opt-services.tailscale.enable
  services.tailscale.enable = true;

  # nixpkgsで配布されていないGUIアプリはHomebrewのCaskで管理する
  homebrew = {
    enable = true;
    brews = [ ];
    onActivation = {
      autoUpdate = true; # switch時にbrew updateして最新のtapを取得する
      upgrade = true; # 宣言済みのformula・caskを最新版に上げる
      cleanup = "uninstall"; # 宣言外のパッケージを削除する（"zap"はアプリデータも消すので使わない）
    };
  };

}
