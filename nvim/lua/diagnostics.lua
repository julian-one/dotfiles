local diagnostic_signs = {
	Error = "󰅚 ",
	Warn = "󰀪 ",
	Hint = "󰌶 ",
	Info = "󰋽 ",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
		focusable = true,
		style = "minimal",
	},
})

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next [D]iagnostic" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev [D]iagnostic" })
vim.keymap.set(
	"n",
	"<leader>q",
	vim.diagnostic.setloclist,
	{ desc = "Open diagnostic [Q]uickfix list" }
)

--- Toggle expanded multi-line diagnostic for the current line
vim.keymap.set("n", "<leader>tv", function()
	if vim.diagnostic.config().virtual_lines then
		vim.diagnostic.config({
			virtual_text = { prefix = "●", spacing = 4 },
			virtual_lines = false,
		})
	else
		vim.diagnostic.config({
			virtual_text = false,
			virtual_lines = { current_line = true },
		})
	end
end, { desc = "[T]oggle diagnostic [V]irtual lines" })
