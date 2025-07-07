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
			},
		},
		config = function()
			local neotest = require("neotest")
			local root_dir = vim.fn.getcwd()
			local coverage_file = root_dir .. "/coverage.out"

			local neotest_golang_opts = {
				runner = "go",
				go_test_args = {
					"-v",
					"-race",
					"-count=1",
					"-coverpkg=./...",
					"-coverprofile=" .. coverage_file,
				},
			}

			neotest.setup({
				adapters = {
					require("neotest-golang")(neotest_golang_opts),
				},
			})

			local map = vim.keymap.set

			-- Run nearest test
			map("n", "<leader>tn", function()
				neotest.run.run({ cwd = root_dir })
			end, { desc = "Neotest: run nearest test from root" })

			-- Run current file
			map("n", "<leader>tf", function()
				neotest.run.run({ path = vim.fn.expand("%"), cwd = root_dir })
			end, { desc = "Neotest: run current file from root" })

			-- Run all tests from root
			map("n", "<leader>ta", function()
				neotest.run.run({ path = "./test/unit", cwd = root_dir })
			end, { desc = "Neotest: run full unit tests from root" })

			-- Debug unit tests
			map("n", "<leader>tD", function()
				neotest.run.run({ path = "./test/unit", strategy = "dap", cwd = root_dir })
			end, { desc = "Neotest: debug unit tests from root" })

			-- Misc controls
			map("n", "<leader>ts", neotest.summary.toggle, { desc = "Neotest: toggle summary panel" })
			map("n", "<leader>to", neotest.output_panel.toggle, { desc = "Neotest: toggle output panel" })
			map("n", "<leader>tS", neotest.run.stop, { desc = "Neotest: stop test run" })
		end,
	},
}
