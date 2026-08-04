vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })

vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

vim.keymap.set('x', '<', '<gv', { desc = 'Indent left' })
vim.keymap.set('x', '>', '>gv', { desc = 'Indent right' })

vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move selection up' })
vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move selection down' })
