# nixvim設定の起点。nixCats版 nvim/init.lua + nvim/lua/core/ の移植。
{ lib, ... }:
{
  imports = [
    ./ui.nix
    ./editor.nix
    ./lsp.nix
    ./agents.nix
  ];

  globals = {
    mapleader = " ";
    maplocalleader = "\\";
  };

  opts = {
    number = true;
    # macのシステムとclipboardを共有
    clipboard = "unnamedplus";
    tabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    # 外部ツールによるファイル変更を自動リロード
    autoread = true;
  };

  autoCmd = [
    {
      event = [
        "FocusGained"
        "BufEnter"
        "CursorHold"
        "TermLeave"
      ];
      pattern = "*";
      command = "checktime";
    }
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>w<cr>";
      options.desc = "Save file";
    }
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>qa<cr>";
      options.desc = "Quit";
    }
    {
      mode = "t";
      key = "<C-q>";
      action = "<c-\\><c-n>";
      options.desc = "Change to Normal Mode";
    }
    {
      mode = "n";
      key = "<leader>d";
      action = lib.nixvim.mkRaw "vim.diagnostic.open_float";
      options.desc = "Show diagnostic float";
    }
    {
      mode = "n";
      key = "[d";
      action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count = -1 }) end";
      options.desc = "Prev diagnostic";
    }
    {
      mode = "n";
      key = "]d";
      action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count = 1 }) end";
      options.desc = "Next diagnostic";
    }
    {
      mode = "n";
      key = "<leader>cd";
      action = lib.nixvim.mkRaw ''
        function()
          local line = vim.api.nvim_win_get_cursor(0)[1] - 1
          local diags = vim.diagnostic.get(0, { lnum = line })
          if vim.tbl_isempty(diags) then
            vim.notify("この行に診断はありません", vim.log.levels.INFO)
            return
          end
          local lines = {}
          for _, d in ipairs(diags) do
            table.insert(lines, string.format("%s (%s: %s)", d.message, d.source or "?", d.code or "?"))
          end
          local text = table.concat(lines, "\n")
          vim.fn.setreg("+", text)
          vim.notify("診断をクリップボードにコピーしました")
        end
      '';
      options.desc = "Copy diagnostics on line to clipboard";
    }
  ];

  diagnostic.settings = {
    update_in_insert = false;
    virtual_text.format = lib.nixvim.mkRaw ''
      function(diagnostic)
        return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
      end
    '';
    signs.linehl = lib.nixvim.mkRaw ''
      {
        [vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
        [vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
        [vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
        [vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
      }
    '';
  };

  highlight = {
    DiagnosticErrorLine.bg = "#3d1515";
    DiagnosticWarnLine.bg = "#3d2e00";
    DiagnosticHintLine.bg = "#0d2d3d";
    DiagnosticInfoLine.bg = "#1a2d1a";
    DiagnosticDeprecated = {
      strikethrough = true;
      fg = "#808080";
    };
  };
}
