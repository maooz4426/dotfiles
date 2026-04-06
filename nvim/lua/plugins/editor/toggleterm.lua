return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      size = 15,
      direction = "horizontal",
    })

    -- <leader>tt でターミナル開閉
    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

    -- <leader>rr で現在のファイルをコンパイル&実行
    vim.keymap.set("n", "<leader>rr", function()
      local file = vim.fn.expand("%:p")
      local out = vim.fn.expand("%:p:r")
      -- neetcode向けにc++17に指定
      local cmd = string.format("g++ -std=c++17 -O2 %s -o %s && %s", file, out, out)
      require("toggleterm.terminal").Terminal:new({ cmd = cmd, close_on_exit = false }):toggle()
    end, { desc = "Compile and run C++" })
  end,
}
