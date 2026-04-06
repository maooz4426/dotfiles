{pkgs, config, lib, ...}: {
    imports = [
        ../../modules/tmux.nix
        ../../modules/karabiner.nix
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
    ];

    programs.go = {
        enable = true;
    };

    programs.gh = {
        enable = true;
    };

    programs.neovim = {
        enable = true;
    };

    xdg.configFile."nvim/init.lua" = lib.mkForce {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Develop/dotfiles/nvim/init.lua";
    };

    xdg.configFile."nvim/lua" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Develop/dotfiles/nvim/lua";
    };

}
