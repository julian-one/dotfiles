local dap = require("dap")
local dapui = require("dapui")

dapui.setup({})
require("nvim-dap-virtual-text").setup({})
require("dap-go").setup({})

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
)
vim.fn.sign_define(
	"DapStopped",
	{ text = "▶", texthl = "DiagnosticInfo", linehl = "Visual", numhl = "" }
)
vim.fn.sign_define(
	"DapLogPoint",
	{ text = "◆", texthl = "DiagnosticHint", linehl = "", numhl = "" }
)

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

local map = function(lhs, fn, desc)
	vim.keymap.set("n", lhs, fn, { desc = "[D]ebug: " .. desc })
end

map("<leader>db", dap.toggle_breakpoint, "Toggle [B]reakpoint")
map("<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Condition: "))
end, "Conditional [B]reakpoint")
map("<leader>dc", dap.continue, "[C]ontinue")
map("<leader>di", dap.step_into, "Step [I]nto")
map("<leader>do", dap.step_over, "Step [O]ver")
map("<leader>dO", dap.step_out, "Step [O]ut")
map("<leader>dr", dap.repl.toggle, "Toggle [R]EPL")
map("<leader>dl", dap.run_last, "Run [L]ast")
map("<leader>du", dapui.toggle, "Toggle [U]I")
map("<leader>dt", dap.terminate, "[T]erminate")
map("<leader>dk", function()
	require("dap.ui.widgets").hover()
end, "Hover variable")

-- Go-specific
map("<leader>dT", function()
	require("dap-go").debug_test()
end, "Debug Go [T]est")
