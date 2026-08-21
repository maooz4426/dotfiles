# macOS汎用のhome-manager設定。
# 別のMacを新規セットアップしても欲しいものをここに置く。
# 機種固有の設定（Cask一覧・開発環境等）はprofiles/maozbook/home.nixに書く。
{ ... }:
{
  imports = [
    ../../modules/home
    ../../modules/home/neovim.nix
    ../../modules/home/nixvim.nix
    ../../modules/home/ghostty.nix
    ../../modules/home/karabiner.nix
  ];
}
