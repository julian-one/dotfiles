vim.keymap.set("n", "<leader>on", vim.cmd.Ex, { desc = "[O]pen [N]etrw" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to system clipboard" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "[Esc]ape terminal mode" })
--
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Terminal state
local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

-- Helper to create a centered floating window
local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = vim.api.nvim_buf_is_valid(opts.buf) and opts.buf or vim.api.nvim_create_buf(false, true)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	})

	return { buf = buf, win = win }
end

-- Toggle floating terminal
local function toggle_terminal()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window({ buf = state.floating.buf })

		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.fn.termopen(vim.o.shell)
		end

		vim.cmd("startinsert")
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

-- :Floaterminal command
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

-- <leader>tt mapping to toggle terminal
vim.keymap.set("n", "<leader>tt", toggle_terminal, { desc = "[T]oggle [T]erminal" })

-- no macros plz
vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true })
