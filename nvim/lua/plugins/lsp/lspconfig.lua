return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
	dev = require("nixCatsUtils").isNixCats,
	config = function()
		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

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

		-- macOSではNixのラッパーがCPLUS_INCLUDE_PATHを汚染するため、query-driverで回避
		if vim.fn.has("mac") == 1 then
			vim.lsp.config("clangd", {
				cmd = { "clangd", "--query-driver=/usr/bin/clang++" },
			})
		end

		vim.lsp.config("omnisharp", {
			cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
			settings = {
				FormattingOptions = { EnableEditorConfigSupport = true },
				RoslynExtensionsOptions = { EnableAnalyzersSupport = true },
			},
		})

		vim.lsp.enable({ "lua_ls", "ts_ls", "gopls", "nil_ls", "clangd", "terraformls", "gh_actions_ls", "jdtls", "omnisharp", "helm_ls" })
	end,
}
