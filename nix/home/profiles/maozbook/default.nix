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
    ];

    programs.go = {
        enable = true;
    };

    programs.gh = {
        enable = true;
    };

}
