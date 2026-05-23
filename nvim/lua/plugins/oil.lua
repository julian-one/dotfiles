require("oil").setup({
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
})
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File [E]xplorer" })
