return {
	"folke/tokyonight.nvim",
	dev = require("nixCatsUtils").isNixCats,
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme tokyonight-night]])
	end,
}
