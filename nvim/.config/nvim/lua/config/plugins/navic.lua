return {
	{
		"SmiteshP/nvim-navic",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("nvim-navic").setup({
				lsp = {
					auto_attach = false,
					preference = { "templ", "html" },
				},
				highlight = false,
				separator = " > ",
				depth_limit = 0,
				depth_limit_indicator = "..",
				safe_output = true,
				lazy_update_context = false,
				click = false,
			})
		end,
	},
}
