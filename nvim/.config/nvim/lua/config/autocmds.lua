vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		vim.opt.number = false
		vim.opt.relativenumber = false
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Set up LSP keymaps when LSP attaches",
	group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
	callback = function(args)
		local bufnr = args.buf

		-- Define LSP keymaps with descriptions
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "[G]oto [D]definition" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "[G]oto [R]eferences" })
		vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "[G]oto [I]mplementation" })
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type [D]definition" })
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "[R]e[N]ame Symbol" })
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "[C]ode [A]ction" })
	end,
})
