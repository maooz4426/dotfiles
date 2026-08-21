# Claude Code連携。nixCats版 nvim/lua/plugins/agents/claude.lua の移植。
{ lib, ... }:
{
  plugins.claudecode = {
    enable = true;
    settings.terminal_cmd = "claude";
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>ac";
      action = "<cmd>ClaudeCode<cr>";
      options.desc = "Toggle Claude";
    }
    {
      mode = "n";
      key = "<leader>af";
      action = "<cmd>ClaudeCodeFocus<cr>";
      options.desc = "Focus Claude";
    }
    {
      mode = "n";
      key = "<leader>ar";
      action = "<cmd>ClaudeCode --resume<cr>";
      options.desc = "Resume Claude";
    }
    {
      mode = "n";
      key = "<leader>aC";
      action = "<cmd>ClaudeCode --continue<cr>";
      options.desc = "Continue Claude";
    }
    {
      mode = "n";
      key = "<leader>am";
      action = "<cmd>ClaudeCodeSelectModel<cr>";
      options.desc = "Select Claude model";
    }
    {
      mode = "n";
      key = "<leader>ab";
      action = "<cmd>ClaudeCodeAdd %<cr>";
      options.desc = "Add current buffer";
    }
    {
      mode = "v";
      key = "<leader>as";
      action = "<cmd>ClaudeCodeSend<cr>";
      options.desc = "Send to Claude";
    }
    {
      mode = "n";
      key = "<leader>aa";
      action = "<cmd>ClaudeCodeDiffAccept<cr>";
      options.desc = "Accept diff";
    }
    {
      mode = "n";
      key = "<leader>ad";
      action = "<cmd>ClaudeCodeDiffDeny<cr>";
      options.desc = "Deny diff";
    }
  ];

  # ファイルツリー（NvimTree/neo-tree/oil/minifiles/netrw）でのみ <leader>as をTreeAddに割り当てる
  autoCmd = [
    {
      event = "FileType";
      pattern = [
        "NvimTree"
        "neo-tree"
        "oil"
        "minifiles"
        "netrw"
      ];
      callback = lib.nixvim.mkRaw ''
        function()
          vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", { buffer = true, desc = "Add file" })
        end
      '';
    }
  ];
}
