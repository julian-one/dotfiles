-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Diagnostics keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Movement and search
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center view' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center view' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search match and center view' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search match and center view' })

-- LSP actions
vim.keymap.set('n', '<leader>R', '<cmd>LspRestart<cr>', { desc = 'Restart LSP' })

-- Quick escape from insert mode
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode quickly' })

-- File exploring
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Open file explorer' })

-- Clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })

-- Quickfix and location list navigation
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz', { desc = 'Next quickfix entry' })
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz', { desc = 'Previous quickfix entry' })
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Next location' })
