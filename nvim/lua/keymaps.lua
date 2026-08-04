vim.keymap.set('n', '<leader>re', '<cmd>restart<cr>', { desc = 'Restart nvim and restore session' })

vim.keymap.set('n', 'U', '<c-r>', { silent = true })

vim.keymap.set('x', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('x', '>', '>gv', { desc = 'Indent right and reselect' })

vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move selection up' })
vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move selection down' })

vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })

vim.keymap.set('n', '<leader>rs', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Substitute word under cursor' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'Diagnostics to quickfix' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostic float' })
