{pkgs, config, lib, nixCats, ...}: {
    imports = [
        ../../modules/tmux.nix
        ../../modules/karabiner.nix
        nixCats.homeModule
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

    nixCats = {
        enable = true;
        packageNames = [ "myNvim" ];

        luaPath = ../../../../nvim;

        categoryDefinitions.replace = ({ pkgs, ... }: {
            startupPlugins = {
                lsp = with pkgs.vimPlugins; [
                    nvim-lspconfig
                    nvim-cmp
                    cmp-nvim-lsp
                    cmp-buffer
                    cmp-path
                    luasnip
                    cmp_luasnip
                ];
                ui = with pkgs.vimPlugins; [
                    alpha-nvim
                    mini-nvim
                    plenary-nvim
                    kanagawa-nvim
                    nvim-tree-lua
                    nvim-web-devicons
                ];
                editor = with pkgs.vimPlugins; [
                    (nvim-treesitter.withPlugins (p: [
                        p.go p.bash p.c p.diff p.html p.javascript p.json
                        p.lua p.luadoc p.luap p.markdown p.python p.toml
                        p.tsx p.typescript p.yaml
                    ]))
                    telescope-nvim
                    toggleterm-nvim
                    markdown-preview-nvim
                ];
            };
        });

        packageDefinitions = {
            replace = {
                myNvim = { pkgs, ... }: {
                    settings = {
                        wrapRc = false;
                        aliases = [ "nvim" "vim" "vi" ];
                    };
                    categories = {
                        lsp = true;
                        ui = true;
                        editor = true;
                    };
                };
            };
        };
    };

    xdg.configFile."nvim/init.lua" = lib.mkForce {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Develop/dotfiles/nvim/init.lua";
    };

    xdg.configFile."nvim/lua" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Develop/dotfiles/nvim/lua";
    };

}
