vim.pack.add {
  { src = 'https://github.com/kevinhwang91/nvim-hlslens' },
}

require('hlslens').setup {
  calm_down = true,
}

local start_lens = "<cmd>lua require('hlslens').start()<cr>"

vim.keymap.set('n', 'n', "<cmd>execute('normal! ' . v:count1 . 'nzzzv')<cr>" .. start_lens, { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', "<cmd>execute('normal! ' . v:count1 . 'Nzzzv')<cr>" .. start_lens, { desc = 'Previous search result (centered)' })
vim.keymap.set('n', '*', '*' .. start_lens, { desc = 'Search word under cursor forward' })
vim.keymap.set('n', '#', '#' .. start_lens, { desc = 'Search word under cursor backward' })
