return {
	"akinsho/toggleterm.nvim",
	dev = require("nixCatsUtils").isNixCats,
	config = function()
		require("toggleterm").setup({
			size = 15,
			direction = "horizontal",
		})

		-- <leader>tt でターミナル開閉
		vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
	end,
}
