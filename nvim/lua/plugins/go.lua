vim.pack.add {
  { src = 'https://github.com/fredrikaverpil/godoc.nvim', version = vim.version.range '*' },
  { src = 'https://github.com/olexsmir/gopher.nvim' },
}

require('godoc').setup {}
require('gopher').setup {}
