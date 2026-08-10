vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit" })
vim.keymap.set("t", "<C-q>", "<c-\\><c-n>", { desc = "Change to Normal Mode" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic float" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>cd", function()
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local diags = vim.diagnostic.get(0, { lnum = line })
	if vim.tbl_isempty(diags) then
		vim.notify("この行に診断はありません", vim.log.levels.INFO)
		return
	end
	local lines = {}
	for _, d in ipairs(diags) do
		table.insert(lines, string.format("%s (%s: %s)", d.message, d.source or "?", d.code or "?"))
	end
	local text = table.concat(lines, "\n")
	vim.fn.setreg("+", text)
	vim.notify("診断をクリップボードにコピーしました")
end, { desc = "Copy diagnostics on line to clipboard" })

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
