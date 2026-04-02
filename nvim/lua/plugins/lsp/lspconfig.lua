return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()

    local servers = { "lua_ls", "ts_ls", "gopls","nil" }

    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    -- 全サーバー共通の設定（ワイルドカード）
    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    -- キーマップはLSPアタッチ時に設定
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local opts = { noremap = true, silent = true, buffer = args.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      end,
    })

    -- サーバーを有効化
    vim.lsp.enable(servers)
  end,
}
