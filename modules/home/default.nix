# 全ホスト共通のhome-manager設定の束ね。
# neovim/ghostty/karabinerはホストによって使う/使わないが分かれるため、
# ここには含めずプロファイル側で個別にimportする。
{ username, homedir, ... }:
{
  imports = [
    ./tmux.nix
    ./git.nix
    ./starship.nix
    ./zsh.nix
    ./cli.nix
  ];

  home.stateVersion = "25.05";
  home.username = username;
  home.homeDirectory = homedir;
}
