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
		keys = {
			{ "<leader>ta", function() require("neotest").run.attach() end, desc = "[T]est [A]ttach" },
			{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[T]est run [F]ile" },
			{ "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[T]est [A]ll files" },
			{ "<leader>tS", function() require("neotest").run.run({ suite = true }) end, desc = "[T]est [S]uite" },
			{ "<leader>tn", function() require("neotest").run.run() end, desc = "[T]est [N]earest" },
			{ "<leader>tl", function() require("neotest").run.run_last() end, desc = "[T]est [L]ast" },
			{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "[T]est [S]ummary" },
			{ "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[T]est [O]utput" },
			{ "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "[T]est [O]utput panel" },
			{ "<leader>tt", function() require("neotest").run.stop() end, desc = "[T]est [T]erminate" },
			{ "<leader>td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end, desc = "[T]est [D]ebug nearest" },
			{ "<leader>tD", function() require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" }) end, desc = "[T]est [D]ebug file" },
		},
		config = function()
			local neotest = require("neotest")
			
			local function get_go_module_name()
				local go_mod_path = vim.fn.getcwd() .. "/go.mod"
				if vim.fn.filereadable(go_mod_path) == 1 then
					local lines = vim.fn.readfile(go_mod_path, "", 1)
					if #lines > 0 then
						local module_line = lines[1]
						local module_name = module_line:match("^module%s+(.+)")
						return module_name or ""
					end
				end
				return ""
			end

			local module_name = get_go_module_name()
			local coverage_args = {}
			
			if module_name ~= "" then
				coverage_args = {
					"-coverpkg=" .. module_name .. "/...",
					"-coverprofile=coverage.out",
				}
			end

			local neotest_golang_opts = {
				runner = "go",
				go_test_args = vim.list_extend({
					"-v",
					"-race",
					"-count=1",
				}, coverage_args),
			}
			
			neotest.setup({
				adapters = {
					require("neotest-golang")(neotest_golang_opts),
				},
			})
		end,
	},
}
