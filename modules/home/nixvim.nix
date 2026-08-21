# nixvimベースのNeovim（nixCatsからの移行先）。
# programs.nixvim（home-manager module）は使わず、standaloneパッケージとして
# home.packages に足す。
{ pkgs, nixvim, ... }:
let
  nvimPkg = nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
    inherit pkgs;
    module = import ./nixvim/config.nix;
  };
in
{
  home.packages = [
    (pkgs.writeShellScriptBin "nvim" ''
      exec ${nvimPkg}/bin/nvim "$@"
    '')
    (pkgs.writeShellScriptBin "vim" ''
      exec ${nvimPkg}/bin/nvim "$@"
    '')
    (pkgs.writeShellScriptBin "vi" ''
      exec ${nvimPkg}/bin/nvim "$@"
    '')
  ];
}
