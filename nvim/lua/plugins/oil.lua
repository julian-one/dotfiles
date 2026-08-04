vim.pack.add {
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/refractalize/oil-git-status.nvim' },
}

require('oil').setup {
  win_options = {
    signcolumn = 'yes:2',
    number = false,
    relativenumber = false,
  },
  view_options = {
    show_hidden = true,
    is_always_hidden = function(name) return name == '..' or name == '.git' or name == '.DS_Store' end,
  },
}

require('oil-git-status').setup {
  symbols = {
    index = {
      ['!'] = ' ',
      ['?'] = ' ',
      ['A'] = '+',
      ['C'] = '+',
      ['D'] = '-',
      ['M'] = '~',
      ['R'] = '→',
      ['T'] = '~',
      ['U'] = '!',
      [' '] = ' ',
    },
    working_tree = {
      ['!'] = ' ',
      ['?'] = '?',
      ['A'] = '+',
      ['C'] = '+',
      ['D'] = '-',
      ['M'] = '~',
      ['R'] = '→',
      ['T'] = '~',
      ['U'] = '!',
      [' '] = ' ',
    },
  },
}

vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
