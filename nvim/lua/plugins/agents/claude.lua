return {
  "coder/claudecode.nvim",
  dev = require("nixCatsUtils").isNixCats,
  dependencies = { "folke/snacks.nvim" },
    opts = {
    terminal_cmd = "claude", -- Point to local installation
  },
}
