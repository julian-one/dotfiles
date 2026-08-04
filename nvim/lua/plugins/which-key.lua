vim.pack.add {
  { src = 'https://github.com/folke/which-key.nvim' },
}

local which_key = require 'which-key'

which_key.setup {
  preset = 'helix',
}

which_key.add {
  { '<leader>c', group = 'Code' },
  { '<leader>g', group = 'Git' },
  { '<leader>s', group = 'Search' },
  { '<leader>z', group = 'Zdiff' },
  { 'gr', group = 'LSP' },
}
