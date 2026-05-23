require("diffview").setup({
	enhanced_diff_hl = true,
	view = {
		merge_tool = { layout = "diff3_mixed" },
	},
})

vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "[G]it [D]iff (working tree)" })
vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "[G]it [D]iff close" })
vim.keymap.set(
	"n",
	"<leader>gh",
	"<cmd>DiffviewFileHistory<cr>",
	{ desc = "[G]it file [H]istory (repo)" }
)
vim.keymap.set(
	"n",
	"<leader>gH",
	"<cmd>DiffviewFileHistory %<cr>",
	{ desc = "[G]it file [H]istory (current file)" }
)
