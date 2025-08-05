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

			-- Get module name from go.mod
			local go_mod_path = root_dir .. "/go.mod"
			local module_name = ""
			local file = io.open(go_mod_path, "r")
			if file then
				local first_line = file:read("*line")
				if first_line and first_line:match("^module ") then
					module_name = first_line:match("^module%s+(.+)")
				end
				file:close()
			end

			local neotest_golang_opts = {
				runner = "go",
				go_test_args = {
					"-v",
					"-race",
					"-count=1",
					"-coverpkg=" .. module_name .. "/internal/...," .. module_name .. "/route/...",
					"-coverprofile=" .. coverage_file,
				},
			}
			neotest.setup({
				adapters = {
					require("neotest-golang")(neotest_golang_opts),
				},
			})
			-- Keymaps
			vim.keymap.set("n", "<leader>ta", function()
				require("neotest").run.attach()
			end, { desc = "[t]est [a]ttach" })
			vim.keymap.set("n", "<leader>tf", function()
				require("neotest").run.run(vim.fn.expand("%"))
			end, { desc = "[t]est run [f]ile" })
			vim.keymap.set("n", "<leader>tA", function()
				require("neotest").run.run(vim.uv.cwd())
			end, { desc = "[t]est [A]ll files" })
			vim.keymap.set("n", "<leader>tS", function()
				require("neotest").run.run({ suite = true })
			end, { desc = "[t]est [S]uite" })
			vim.keymap.set("n", "<leader>tn", function()
				require("neotest").run.run()
			end, { desc = "[t]est [n]earest" })
			vim.keymap.set("n", "<leader>tl", function()
				require("neotest").run.run_last()
			end, { desc = "[t]est [l]ast" })
			vim.keymap.set("n", "<leader>ts", function()
				require("neotest").summary.toggle()
			end, { desc = "[t]est [s]ummary" })
			vim.keymap.set("n", "<leader>to", function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end, { desc = "[t]est [o]utput" })
			vim.keymap.set("n", "<leader>tO", function()
				require("neotest").output_panel.toggle()
			end, { desc = "[t]est [O]utput panel" })
			vim.keymap.set("n", "<leader>tt", function()
				require("neotest").run.stop()
			end, { desc = "[t]est [t]erminate" })
			vim.keymap.set("n", "<leader>td", function()
				require("neotest").run.run({ suite = false, strategy = "dap" })
			end, { desc = "Debug nearest test" })
			vim.keymap.set("n", "<leader>tD", function()
				require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
			end, { desc = "Debug current file" })
		end,
	},
}
