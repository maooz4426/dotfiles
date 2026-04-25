return {
  "stevearc/conform.nvim",
  dev = require("nixCatsUtils").isNixCats,
  event = { "BufWritePre" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.go",
      callback = function()
        vim.fn.jobstart({ "go", "mod", "tidy" }, { cwd = vim.fn.getcwd() })
      end,
    })
  end,
}
