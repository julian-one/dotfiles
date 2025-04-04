return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
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
