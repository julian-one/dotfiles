require("render-markdown").setup({
	completions = { lsp = { enabled = true } },
	code = {
		sign = false,
		width = "block",
		right_pad = 2,
	},
	heading = {
		sign = false,
		width = "full",
	},
})

vim.keymap.set("n", "<leader>tm", function()
	require("render-markdown").toggle()
end, { desc = "[T]oggle [M]arkdown rendering" })
