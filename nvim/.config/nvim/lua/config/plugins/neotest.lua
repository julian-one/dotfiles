return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			{
				"fredrikaverpil/neotest-golang",
				version = "*",
				dependencies = {
					"andythigpen/nvim-coverage", -- Added dependency
				},
			},
		},
		config = function()
			local neotest = require("neotest")

			-- adapter options
			local neotest_golang_opts = { -- Specify configuration
				runner = "go",
				go_test_args = {
					"-v",
					"-race",
					"-count=1",
					"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
				},
			}

			neotest.setup({
				adapters = {
					require("neotest-golang")(neotest_golang_opts),
				},
			})

			-- Keymaps for running & debugging tests
			local map = vim.keymap.set
			map("n", "<leader>tn", function()
				neotest.run.run()
			end, { desc = "Neotest: run nearest" })
			map("n", "<leader>tf", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "Neotest: run file" })
			map("n", "<leader>tD", function()
				neotest.run.run({ strategy = "dap" })
			end, { desc = "Neotest: debug test" })
			map("n", "<leader>ts", neotest.summary.toggle, { desc = "Neotest: toggle summary" })
			map("n", "<leader>to", neotest.output_panel.toggle, { desc = "Neotest: toggle output panel" })
			map("n", "<leader>tS", neotest.run.stop, { desc = "Neotest: stop test" })
		end,
	},
}
