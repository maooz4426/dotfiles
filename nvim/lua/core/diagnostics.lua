vim.api.nvim_set_hl(0, "DiagnosticErrorLine", { bg = "#3d1515" })
vim.api.nvim_set_hl(0, "DiagnosticWarnLine", { bg = "#3d2e00" })
vim.api.nvim_set_hl(0, "DiagnosticHintLine", { bg = "#0d2d3d" })
vim.api.nvim_set_hl(0, "DiagnosticInfoLine", { bg = "#1a2d1a" })

vim.diagnostic.config({
	update_in_insert = false,
	virtual_text = {
		format = function(diagnostic)
			return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
		end,
	},
	signs = {
		text = {
			-- ...
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticErrorLine",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarnLine",
			[vim.diagnostic.severity.HINT] = "DiagnosticHintLine",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfoLine",
		},
	},
})
