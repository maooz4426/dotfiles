# NixOSマシン（manix）用のhome-manager設定。
# macOS専用モジュール（karabiner、ghostty）は除外する。
{
  pkgs,
  config,
  lib,
  nixCats,
  claude-code,
  ...
}:
{
  imports = [
    ../../modules/tmux.nix
    ../../modules/git.nix
  ];

  home.stateVersion = "25.05";
  home.username = "maoz";
  home.homeDirectory = "/home/maoz";

  home.packages = [
    pkgs.vim
    pkgs.yazi
    pkgs.gcc
    pkgs.gnumake
    pkgs.clang-tools
    pkgs.lua-language-server
    pkgs.typescript-language-server
    pkgs.gopls
    pkgs.nil
    pkgs.terraform-ls
    pkgs.gitleaks
    pkgs.mosh
    pkgs.google-cloud-sdk
    pkgs.claude-code
  ];

  nixpkgs.overlays = [ claude-code.overlays.default ];

  programs.go = {
    enable = true;
  };

  programs.gh = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent.enable = true;

  programs.zsh = {
    enable = true;

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];

    sessionVariables = {
      GOPATH = "$HOME/go";
    };

    initContent = ''
      # yazi
      function yz() {
          tmp="$(mktemp -t "yazi-cwd.XXXXX")"
          yazi --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              cd -- "$cwd"
          fi
          rm -f -- "$tmp"
      }
    '';
  };

  home.sessionPath = [
    "$HOME/go/bin"
  ];

}
