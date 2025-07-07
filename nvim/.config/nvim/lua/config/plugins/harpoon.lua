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
			local tele_conf = require("telescope.config").values
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")

			-- Initialize Harpoon
			harpoon:setup()

			-- Add file
			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end, { desc = "Harpoon: Add current file" })

			-- Toggle quick menu
			vim.keymap.set("n", "<leader>hh", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Harpoon: Toggle quick menu" })

			-- Navigate to specific files with <leader>h1..h4
			for i = 1, 4 do
				vim.keymap.set("n", "<leader>h" .. i, function()
					harpoon:list():select(i)
				end, { desc = "Harpoon: Go to file " .. i })
			end

			-- Cycle through marks
			vim.keymap.set("n", "<leader>hn", function()
				harpoon:list():next()
			end, { desc = "Harpoon: Next mark" })

			vim.keymap.set("n", "<leader>hp", function()
				harpoon:list():prev()
			end, { desc = "Harpoon: Previous mark" })

			-- Telescope picker
			local function harpoon_picker()
				local items = harpoon:list().items or {}
				if vim.tbl_isempty(items) then
					vim.notify("No Harpoon marks set", vim.log.levels.INFO, { title = "Harpoon" })
					return
				end

				local results = vim.tbl_map(function(mark)
					return mark.value
				end, items)

				pickers
					.new({}, {
						prompt_title = "Harpoon Marks",
						finder = finders.new_table({ results = results }),
						previewer = tele_conf.file_previewer({}),
						sorter = tele_conf.generic_sorter({}),
					})
					:find()
			end

			vim.keymap.set("n", "<leader>ht", harpoon_picker, { desc = "Harpoon: Telescope picker" })
		end,
	},
}
