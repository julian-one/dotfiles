--- Provide visual feedback on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

--- Restore cursor position from previous editing session
local restore_cursor_skip = {
	gitcommit = true,
	gitrebase = true,
	hgcommit = true,
	svn = true,
}
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
	callback = function(args)
		if restore_cursor_skip[vim.bo[args.buf].filetype] then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- Defer centering so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

--- Create missing parent directories when writing a new file
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("auto_mkdir", { clear = true }),
	callback = function(args)
		if args.match:match("^%w+://") then
			return -- skip protocol-prefixed buffers (oil://, fugitive://, etc.)
		end
		local dir = vim.fn.fnamemodify(args.match, ":p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

--- Equalize splits when the host window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

--- Prevent automatically continuing comments on new lines
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", { clear = true }),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

--- Highlight exclusively the currently active window
local active_cursorline = vim.api.nvim_create_augroup("active_cursorline", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
	group = active_cursorline,
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

vim.api.nvim_create_autocmd("WinLeave", {
	group = active_cursorline,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
