# エディタ操作系プラグイン。nixCats版 nvim/lua/plugins/editor/ の移植。
{ lib, config, ... }:
{
  plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
      folds.enable = true;
    };
    grammarPackages =
      with config.plugins.treesitter.package.builtGrammars;
      [
        go
        bash
        c
        diff
        html
        javascript
        json
        lua
        luadoc
        luap
        markdown
        python
        toml
        tsx
        typescript
        yaml
        terraform
        c_sharp
        haskell
      ];
  };

  plugins.telescope = {
    enable = true;
    settings = {
      defaults = {
        layout_strategy = "horizontal";
        layout_config.prompt_position = "top";
        sorting_strategy = "ascending";
        file_ignore_patterns = [
          ".git/"
          "node_modules"
        ];
      };
      pickers.find_files.hidden = true;
    };
  };

  plugins.toggleterm = {
    enable = true;
    settings = {
      size = 15;
      direction = "horizontal";
    };
  };

  plugins.markdown-preview.enable = true;

  plugins.lazygit.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<C-p>";
      action = lib.nixvim.mkRaw "require('telescope.builtin').find_files";
    }
    {
      mode = "n";
      key = "<C-f>";
      action = lib.nixvim.mkRaw "require('telescope.builtin').live_grep";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = lib.nixvim.mkRaw "require('telescope.builtin').buffers";
    }
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>ToggleTerm<cr>";
      options.desc = "Toggle terminal";
    }
    {
      mode = "n";
      key = "<leader>lg";
      action = "<cmd>LazyGit<cr>";
      options.desc = "LazyGit";
    }
  ];

  # C/C++バッファでのコンパイル&実行（元 core/key.lua のFileType autocmd）
  autoCmd = [
    {
      event = "FileType";
      pattern = [
        "c"
        "cpp"
      ];
      callback = lib.nixvim.mkRaw ''
        function()
          vim.keymap.set("n", "<leader>cr", function()
            local file = vim.fn.expand("%:p")
            local out = vim.fn.expand("%:p:r")
            local cmd = string.format("g++ -std=c++17 -O2 %s -o %s && %s", file, out, out)
            require("toggleterm.terminal").Terminal:new({ cmd = cmd, close_on_exit = false }):toggle()
          end, { buffer = true, desc = "Compile and run C++" })
        end
      '';
    }
  ];
}
