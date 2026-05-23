-- Buffer-local <leader>cd keymap lives in after/ftplugin/go.lua.
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
