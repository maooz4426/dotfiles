# 全プロファイル共通のCLIツール・LSP群。
{ pkgs, ... }:
{
  programs.go.enable = true;
  programs.gh.enable = true;

  home.packages = with pkgs; [
    yazi
    gcc
    clang-tools
    gitleaks
    lua-language-server
    typescript-language-server
    gopls
    nil
    terraform-ls
  ];
}
