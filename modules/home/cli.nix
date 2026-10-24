# 全プロファイル共通のCLIツール。
# LSPサーバーはnvimが lsp.servers.*.enable から自動で用意するため、ここには置かない
# （modules/home/nixvim/lsp.nix を参照）。
{ pkgs, ... }:
{
  programs.gh.enable = true;

  home.packages = with pkgs; [
    go_latest
    yazi
    gitleaks
  ];
}
