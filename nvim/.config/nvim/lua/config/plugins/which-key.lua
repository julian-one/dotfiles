return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 0,
			icons = {
				mappings = vim.g.have_nerd_font,
			},

			spec = {
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>g", group = "[G]it" },
				{ "<leader>x", group = "[X]rouble" },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
