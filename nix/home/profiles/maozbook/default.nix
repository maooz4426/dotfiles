{pkgs, config, lib, nixCats, ...}: {
    imports = [
        ../../modules/tmux.nix
        ../../modules/karabiner.nix
        ../../modules/neovim.nix
        ../../modules/starship.nix
        ../../modules/zsh.nix
        ../../modules/ghostty.nix
    ];

    home.stateVersion = "25.05";
    home.username = "maoz";
    home.homeDirectory = "/Users/maoz";

    home.packages = [
        pkgs.yazi
        pkgs.mosh
        pkgs.gcc
        pkgs.clang-tools
        pkgs.lua-language-server
        pkgs.typescript-language-server
        pkgs.gopls
        pkgs.nil
        pkgs.starship
        pkgs.mariadb.client
    ];

    programs.go = {
        enable = true;
    };

    programs.gh = {
        enable = true;
    }; 
}
