{pkgs,...}: {
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
    ];

    programs.go = {
        enable = true;
    };

    programs.gh = {
        enable = true;
    };

}
