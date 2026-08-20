# WSL2マシン（wslnix）用のhome-manager設定。
# systemdが無効のためssh-agentはzsh initで起動する。
{
  pkgs,
  nixCats,
  claude-code,
  ...
}:
{
  imports = [
    ../../modules/home
    ../../modules/home/neovim.nix
  ];

  home.packages = [
    pkgs.gnumake
    pkgs.google-cloud-sdk
    pkgs.claude-code
  ];

  nixpkgs.overlays = [ claude-code.overlays.default ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  programs.zsh.initContent = ''
    # ssh-agent（systemdなしのため手動起動）
    if [ -z "$SSH_AUTH_SOCK" ]; then
        eval $(ssh-agent -s) > /dev/null
    fi
  '';
}
