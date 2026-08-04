-- ---------------------------------------------------------------------------
-- Flash the text you just yanked
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = true }),
  desc = 'highlight selection on yank',
  callback = function() vim.hl.on_yank { timeout = 200, visual = true } end,
})

-- ---------------------------------------------------------------------------
-- Reopen a file where you left off
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('restore_cursor', { clear = true }),
  desc = 'restore cursor to last position in file',
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')

    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
      vim.api.nvim_win_set_cursor(0, mark)
      vim.schedule(function() vim.cmd 'normal! zz' end)
    end
  end,
})

-- ---------------------------------------------------------------------------
-- Open help full screen
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('help_fullscreen', { clear = true }),
  pattern = 'help',
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= '' then
      return
    end
    if vim.fn.winnr '$' == 1 then
      return
    end
    vim.cmd 'wincmd T'
  end,
})

-- ---------------------------------------------------------------------------
-- Stop comments from continuing themselves
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('no_auto_comment', { clear = true }),
  desc = 'no comment continuation on new lines',
  callback = function() vim.opt_local.formatoptions:remove { 'c', 'r', 'o' } end,
})

-- ---------------------------------------------------------------------------
-- Show the cursor line only in the focused window
-- ---------------------------------------------------------------------------
local cursorline = vim.api.nvim_create_augroup('active_cursorline', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  group = cursorline,
  desc = 'show cursorline in the window being entered',
  callback = function() vim.wo.cursorline = true end,
})

vim.api.nvim_create_autocmd('WinLeave', {
  group = cursorline,
  desc = 'hide cursorline in the window being left',
  callback = function() vim.wo.cursorline = false end,
})
