{...}: {
    nix.enable = false;

    system.stateVersion = 5;
    system.primaryUser = "maoz";

    users.users.maoz.home = "/Users/maoz";

    homebrew = {
        enable = true;
        brews = [];
        casks = [];
    };
}

