return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{
				"<leader>ma",
				function()
					require("harpoon"):list():add()
				end,
				desc = "[M]ark: Add current file",
			},
			{
				"<leader>mm",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "[M]ark: Toggle quick menu",
			},
			{
				"<leader>m1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "[M]ark: Go to file 1",
			},
			{
				"<leader>m2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "[M]ark: Go to file 2",
			},
			{
				"<leader>m3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "[M]ark: Go to file 3",
			},
			{
				"<leader>m4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "[M]ark: Go to file 4",
			},
			{
				"<leader>mn",
				function()
					require("harpoon"):list():next()
				end,
				desc = "[M]ark: Next mark",
			},
			{
				"<leader>mp",
				function()
					require("harpoon"):list():prev()
				end,
				desc = "[M]ark: Previous mark",
			},
			{
				"<leader>mt",
				"<cmd>Telescope harpoon marks<cr>",
				desc = "[M]ark: Telescope picker",
			},
		},
		config = function()
			-- Initialize Harpoon
			require("harpoon"):setup()
		end,
	},
}
