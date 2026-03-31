--- Creates a centered floating window for the terminal.
local function create_floating_window(opts)
	opts = opts or {}

	-- Calculate window dimensions defaulting to 80% of the screen size
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)

	-- Calculate the starting coordinates to center the window
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	local buf = nil
	-- If a valid buffer was provided in `opts`, reuse it
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		-- Otherwise, create a temporary scratch buffer without a file
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- Configure the floating window properties
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded",
	}

	-- Open the floating window with the specified buffer and configuration
	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

--- State to keep track of the floating terminal's buffer and window IDs
local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

--- Toggles the floating terminal window.
--- If the window is not currently open, it is created (reusing the terminal buffer if it exists).
--- If the window is open, it is hidden.
local toggle_terminal = function()
	-- Check if the terminal window is currently open
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		-- Create a new floating window, reusing the previous buffer if it exists
		state.floating = create_floating_window({ buf = state.floating.buf })

		-- If the buffer doesn't have a terminal running inside it yet, start one
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		-- If the window is valid and open, hide it
		vim.api.nvim_win_hide(state.floating.win)
	end
end

--- Create a user command `:Floaterminal` corresponding to the toggle function
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

-- Keybindings for terminal usability
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>t", toggle_terminal, { desc = "[T]oggle terminal" })
