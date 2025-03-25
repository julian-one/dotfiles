return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				hover = {
					enabled = true,
					opts = {
						border = "rounded",
					},
				},
				signature = {
					enabled = true,
					opts = {
						border = "rounded",
					},
				},
			},
		},
		keys = {
			{
				"<leader>nd",
				"<cmd>NoiceDismiss<cr>",
				desc = "[N]oice [D]ismiss Message",
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}
