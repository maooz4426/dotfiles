return {
  "akinsho/bufferline.nvim",
  dev = require("nixCatsUtils").isNixCats,
  event = "VeryLazy",
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      show_buffer_close_icons = true,
      show_close_icon = false,
      separator_style = "slant",
    },
  },
}
