vim.pack.add {
  { src = 'https://github.com/j-hui/fidget.nvim' },
  { src = 'https://github.com/NMAC427/guess-indent.nvim' },
  { src = 'https://github.com/OXY2DEV/markview.nvim' },
  { src = 'https://github.com/OXY2DEV/helpview.nvim' },
  { src = 'https://github.com/m4xshen/smartcolumn.nvim' },
  { src = 'https://github.com/mawkler/modicator.nvim' },
}

require('fidget').setup {
  notification = {
    window = { border = 'rounded' },
  },
}
require('guess-indent').setup {}
require('markview').setup {}
require('helpview').setup {}
require('smartcolumn').setup {}
require('modicator').setup {
  highlights = {
    defaults = { bold = true },
  },
  integration = {
    lualine = { highlight = 'fg' },
  },
}
