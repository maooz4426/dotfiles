{pkgs,...}: {
    imports = [
        ../../modules/tmux.nix
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

    home.file.karabinerMouseVim = {
        target = ".config/karabiner/assets/complex_modifications/mouse_vim.json";
        text = builtins.toJSON {
            title = "Mouse Vim Keys (Ctrl + Opt + hjkl)";
            rules = [
                {
                    description = "Ctrl + Opt + hjkl to mouse movement";
                    manipulators = [
                        {
                            type = "basic";
                            from = { key_code = "h"; modifiers = { mandatory = ["left_control" "left_option"]; optional = ["any"]; }; };
                            to = [{ mouse_key = { x = -1536; }; }];
                        }
                        {
                            type = "basic";
                            from = { key_code = "j"; modifiers = { mandatory = ["left_control" "left_option"]; optional = ["any"]; }; };
                            to = [{ mouse_key = { y = 1536; }; }];
                        }
                        {
                            type = "basic";
                            from = { key_code = "k"; modifiers = { mandatory = ["left_control" "left_option"]; optional = ["any"]; }; };
                            to = [{ mouse_key = { y = -1536; }; }];
                        }
                        {
                            type = "basic";
                            from = { key_code = "l"; modifiers = { mandatory = ["left_control" "left_option"]; optional = ["any"]; }; };
                            to = [{ mouse_key = { x = 1536; }; }];
                        }
                    ];
                }
            ];
        };
    };
}
