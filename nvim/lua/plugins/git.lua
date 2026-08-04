vim.pack.add {
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/tpope/vim-fugitive' },
  { src = 'https://github.com/martindur/zdiff.nvim' },
}

require('gitsigns').setup {
  signs = {
    add = { text = '▎' },
    change = { text = '┆' },
    delete = { text = '▁' },
    topdelete = { text = '▔' },
    changedelete = { text = '┆' },
    untracked = { text = '┆' },
  },
  signs_staged_enable = false,
  current_line_blame = true,
  current_line_blame_formatter = '<author>, <author_time:%R>',
}

require('zdiff').setup()

vim.keymap.set('n', '<leader>gm', '<cmd>Gitsigns diffthis main<cr>', { desc = 'Diff against main' })
vim.keymap.set('n', '<leader>gs', '<cmd>15split | 0Git<cr>', { desc = 'Git fugitive status' })
vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiffsplit<cr>', { desc = 'Git diff split' })
vim.keymap.set('n', '<leader>gl', '<cmd>Git log --oneline<cr>', { desc = 'Git log' })

vim.keymap.set('n', '<leader>zd', function() require('zdiff').open() end, { desc = 'Zdiff (uncommitted)' })
vim.keymap.set('n', '<leader>zD', function() require('zdiff').open 'main' end, { desc = 'Zdiff (vs main)' })
