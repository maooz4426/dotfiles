# nixCatsフレームワークを使ったNeovimの設定。
# Luaの設定ファイルはシンボリックリンクで参照しており、nixのビルドを経由せずに直接編集できる。
{ pkgs, config, lib, nixCats, ... }: {
    imports = [
        nixCats.homeModule
    ];

    nixCats = {
        enable = true;
        packageNames = [ "myNvim" ];

        luaPath = ../../../nvim;

        categoryDefinitions.replace = ({ pkgs, ... }: {
            lspsAndRuntimeDeps = {
                lsp = with pkgs; [
                    stylua
                ];
            };
            startupPlugins = {
                lsp = with pkgs.vimPlugins; [
                    nvim-lspconfig
                    nvim-cmp
                    cmp-nvim-lsp
                    cmp-buffer
                    cmp-path
                    luasnip
                    cmp_luasnip
                    conform-nvim
                ];
                ui = with pkgs.vimPlugins; [
                    alpha-nvim
                    mini-nvim
                    plenary-nvim
                    kanagawa-nvim
                    nvim-tree-lua
                    nvim-web-devicons
                    snacks-nvim
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
                agents = with pkgs.vimPlugins; [
                    claudecode-nvim
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
                        agents = true;
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
