require("trouble").setup({})

vim.keymap.set(
	"n",
	"<leader>xx",
	"<cmd>Trouble diagnostics toggle<cr>",
	{ desc = "Diagnostics (Trouble)" }
)
vim.keymap.set(
	"n",
	"<leader>xX",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer diagnostics (Trouble)" }
)
vim.keymap.set(
	"n",
	"<leader>xs",
	"<cmd>Trouble symbols toggle focus=false<cr>",
	{ desc = "Symbols (Trouble)" }
)
vim.keymap.set(
	"n",
	"<leader>xl",
	"<cmd>Trouble loclist toggle<cr>",
	{ desc = "Location list (Trouble)" }
)
vim.keymap.set(
	"n",
	"<leader>xq",
	"<cmd>Trouble qflist toggle<cr>",
	{ desc = "Quickfix list (Trouble)" }
)
vim.keymap.set(
	"n",
	"<leader>xr",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP references/defs (Trouble)" }
)
