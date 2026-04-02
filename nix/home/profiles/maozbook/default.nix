{pkgs,...}: {
    home.stateVersion = "25.05";
    home.username = "maoz";
    home.homeDirectory = "/Users/maoz";

    home.packages = [
        pkgs.yazi
    ];
}
