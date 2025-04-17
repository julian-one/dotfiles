return {
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>nd",
				"<cmd>NoiceDismiss<cr>",
				desc = "[N]oice [D]ismiss Message",
			},
		},
	},
}
