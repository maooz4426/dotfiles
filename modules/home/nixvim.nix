# nixvimベースのNeovim（nixCatsからの移行先、並走検証用）。
# programs.nixvim（home-manager module）は使わず、standaloneパッケージとして
# home.packages に足す。これで既存の modules/home/neovim.nix（nixCats版、`nvim`
# コマンド）と衝突せず、`nvim-next` として並走検証できる。
# 動作確認後、nixvim.homeModules.nixvim 経由に切り替えて `nvim` を置き換える。
{ pkgs, nixvim, ... }:
let
  nvimPkg = nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
    inherit pkgs;
    module = import ./nixvim/config.nix;
  };
in
{
  home.packages = [
    (pkgs.writeShellScriptBin "nvim-next" ''
      exec ${nvimPkg}/bin/nvim "$@"
    '')
  ];
}
