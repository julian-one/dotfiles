require("godoc").setup({
	picker = {
		type = "telescope",
	},
	adapters = {
		{
			name = "go",
			opts = {
				-- tree-sitter-godoc + injected tree-sitter-go syntax highlighting.
				-- Parser is registered in plugins/treesitter.lua.
				get_syntax_info = function()
					return {
						filetype = "godoc",
						language = "godoc",
					}
				end,
			},
		},
	},
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("godoc_nvim_keymaps", { clear = true }),
	pattern = "go",
	callback = function(ev)
		vim.keymap.set("n", "<leader>cd", "<cmd>GoDoc<cr>", {
			buffer = ev.buf,
			desc = "[C]ode Go [D]oc",
		})
	end,
})
