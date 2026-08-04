-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Input and timing
vim.o.mouse = ''
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 0
vim.o.updatetime = 200

-- Gutter
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorlineopt = 'number,line'
vim.o.signcolumn = 'yes:1'
vim.o.foldcolumn = '1'

-- Folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevel = 99

-- Text display
vim.o.wrap = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
vim.o.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
vim.opt.fillchars = {
  eob = ' ',
  fold = ' ',
  foldopen = ' ',
  foldclose = '',
  foldsep = ' ',
  foldinner = ' ',
  diff = '╱',
  vert = '│',
  horiz = '─',
  horizup = '┴',
  horizdown = '┬',
  vertleft = '┤',
  vertright = '├',
  verthoriz = '┼',
}

-- UI chrome
vim.o.winborder = 'rounded'
vim.o.pumborder = 'rounded'
vim.o.showmode = false
vim.o.laststatus = 3
vim.o.cmdheight = 0
require('vim._core.ui2').enable {}
vim.opt.shortmess:append 'I'

-- Completion
vim.o.completeopt = 'menu,menuone,popup,noselect'
vim.opt.wildoptions:append 'fuzzy'

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'

-- Files
vim.o.swapfile = false
vim.o.undofile = true
