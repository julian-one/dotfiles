local neotest = require("neotest")

neotest.setup({
	adapters = {
		require("neotest-golang")({
			dap_go_enabled = true,
		}),
		require("neotest-jest")({
			jestCommand = "npx jest --",
			jest_test_discovery = true,
		}),
	},
	output = { open_on_run = false },
	quickfix = { open = false },
	status = { virtual_text = true },
})

local map = function(lhs, fn, desc)
	vim.keymap.set("n", lhs, fn, { desc = "[N]eotest: " .. desc })
end

map("<leader>nr", function()
	neotest.run.run()
end, "[R]un nearest")
map("<leader>nf", function()
	neotest.run.run(vim.fn.expand("%"))
end, "Run [F]ile")
map("<leader>nA", function()
	neotest.run.run(vim.uv.cwd())
end, "Run [A]ll")
map("<leader>nl", function()
	neotest.run.run_last()
end, "Run [L]ast")
map("<leader>nd", function()
	neotest.run.run({ strategy = "dap" })
end, "[D]ebug nearest")
map("<leader>nt", function()
	neotest.run.stop()
end, "S[t]op")
map("<leader>ns", function()
	neotest.summary.toggle()
end, "Toggle [S]ummary")
map("<leader>no", function()
	neotest.output.open({ enter = true, auto_close = true })
end, "Show [O]utput")
map("<leader>nO", function()
	neotest.output_panel.toggle()
end, "Toggle [O]utput panel")
map("<leader>nw", function()
	neotest.watch.toggle(vim.fn.expand("%"))
end, "Toggle [W]atch")
