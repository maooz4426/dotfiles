# nixvimベースのNeovim（nixCatsからの移行先）。
# programs.nixvim（home-manager module）は使わず、standaloneパッケージとして
# home.packages に足す。
{
  pkgs,
  lib,
  nixvim,
  ...
}:
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

  # NixのclangdラッパーがCPLUS_INCLUDE_PATHを汚染する問題を回避する。
  # nixvim/lsp.nixのclangd query-driver設定と対になるdarwin専用の回避策。
  xdg.configFile = lib.mkIf pkgs.stdenv.isDarwin {
    "clangd/config.yaml".text = ''
      CompileFlags:
        Add:
          - -std=c++17
    '';
  };
}
