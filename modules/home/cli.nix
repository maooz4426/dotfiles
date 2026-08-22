# 全プロファイル共通のCLIツール。
# LSPサーバーはnvimが lsp.servers.*.enable から自動で用意するため、ここには置かない
# （modules/home/nixvim/lsp.nix を参照）。
{ pkgs, ... }:
{
  programs.go.enable = true;
  programs.gh.enable = true;

  home.packages = with pkgs; [
    yazi
    gcc
    gitleaks
  ];
}
