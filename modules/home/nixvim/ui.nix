# UI関連プラグイン。nixCats版 nvim/lua/plugins/ui/ の移植。
{ pkgs, lib, ... }:
{
  colorschemes.tokyonight = {
    enable = true;
    settings.style = "night";
  };

  plugins.web-devicons.enable = true;

  # alpha-nvimはNerd Fontアイコンとio.popenを含むため、Nix属性へは変換せず
  # Luaファイルをそのまま読み込む（modules/home/nixvim/lua/alpha.lua）。
  extraPlugins = [ pkgs.vimPlugins.alpha-nvim ];
  extraConfigLua = builtins.readFile ./lua/alpha.lua;

  plugins.nvim-tree = {
    enable = true;
    settings = {
      git.ignore = false;
      on_attach = lib.nixvim.mkRaw ''
        function(bufnr)
          local api = require("nvim-tree.api")
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.del("n", "e", { buffer = bufnr })
        end
      '';
    };
  };

  plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enabled = true;
      dashboard.enabled = true;
      explorer.enabled = true;
      indent.enabled = true;
      input.enabled = true;
      picker.enabled = true;
      notifier.enabled = true;
      quickfile.enabled = true;
      scope.enabled = true;
      scroll.enabled = true;
      statuscolumn.enabled = true;
      words.enabled = true;
    };
  };

  plugins.bufferline = {
    enable = true;
    settings.options = {
      diagnostics = "nvim_lsp";
      show_buffer_close_icons = true;
      show_close_icon = false;
      separator_style = "slant";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>NvimTreeToggle<CR>";
      options.desc = "Toggle file explorer";
    }
    {
      mode = "n";
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options.desc = "Next buffer";
    }
    {
      mode = "n";
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options.desc = "Prev buffer";
    }
  ];
}
