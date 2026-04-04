{...}: {
    nix.enable = false;

    system.stateVersion = 5;
    system.primaryUser = "maoz";

    users.users.maoz.home = "/Users/maoz";

    
    # https://nix-darwin.github.io/nix-darwin/manual/#opt-services.tailscale.enable
    services.tailscale.enable = true;

    homebrew = {
        enable = true;
        brews = [];
        casks = [
            "alt-tab"
            "parsec"
            "claude-code"
            "1password"
            "raycast"
            "ghostty"
            "mactex-no-gui"
            "thunderbird"
            "gcloud-cli"
            "postman"
            "cursor"
            "zotero"
            "session-manager-plugin"
            "karabiner-elements"
        ];
    };
}

