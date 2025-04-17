return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local harpoon = require("harpoon")
			-- REQUIRED: Initialize Harpoon with the default configuration.
			harpoon:setup()

			-- Default keybindings
			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "Harpoon: Add file" })
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Harpoon: Toggle quick menu" })

			vim.keymap.set("n", "<C-h>", function()
				harpoon:list():select(1)
			end, { desc = "Harpoon: Go to file 1" })
			vim.keymap.set("n", "<C-t>", function()
				harpoon:list():select(2)
			end, { desc = "Harpoon: Go to file 2" })
			vim.keymap.set("n", "<C-n>", function()
				harpoon:list():select(3)
			end, { desc = "Harpoon: Go to file 3" })
			vim.keymap.set("n", "<C-s>", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon: Go to file 4" })

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-S-P>", function()
				harpoon:list():prev()
			end, { desc = "Harpoon: Previous mark" })
			vim.keymap.set("n", "<C-S-N>", function()
				harpoon:list():next()
			end, { desc = "Harpoon: Next mark" })

			-- Telescope integration: define a picker to select a harpoon mark via Telescope
			local tele_conf = require("telescope.config").values
			local function harpoon_picker()
				local harpoon_list = harpoon:list()
				local results = {}
				for _, mark in ipairs(harpoon_list.items or {}) do
					table.insert(results, mark.value)
				end

				if #results == 0 then
					vim.notify("No Harpoon marks set", vim.log.levels.INFO, { title = "Harpoon" })
					return
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon Marks",
						finder = require("telescope.finders").new_table({ results = results }),
						previewer = tele_conf.file_previewer({}),
						sorter = tele_conf.generic_sorter({}),
					})
					:find()
			end

			-- Optional: Keybinding for the Telescope picker integration.
			vim.keymap.set("n", "<leader>hp", harpoon_picker, { desc = "Harpoon: Telescope picker" })
		end,
	},
}
