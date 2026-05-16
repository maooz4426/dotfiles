vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })
vim.keymap.set("t", "<C-q>", "<c-\\><c-n>", { desc = "Change to Normal Mode" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		vim.keymap.set("n", "<leader>cr", function()
			local file = vim.fn.expand("%:p")
			local out = vim.fn.expand("%:p:r")
			local cmd = string.format("g++ -std=c++17 -O2 %s -o %s && %s", file, out, out)
			require("toggleterm.terminal").Terminal:new({ cmd = cmd, close_on_exit = false }):toggle()
		end, { buffer = true, desc = "Compile and run C++" })
	end,
})
