-- General options
vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.mouse = 'a'

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- UI settings
vim.opt.signcolumn = 'yes'
vim.opt.wrap = false
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Undo and backups
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true

-- Display options
vim.opt.ruler = false
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'

-- Spell checking
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- Completion menu
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.pumheight = 10
vim.opt.pumblend = 10

-- Tabline
vim.opt.showtabline = 1

-- GUI cursor
vim.opt.guicursor = ''

-- LSP
vim.opt.autoread = false
