-- Basics
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.smoothscroll = true
vim.opt.shortmess:append("I")

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.inccommand = "split"

-- Visual
vim.opt.winborder = "rounded"
vim.opt.breakindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.completeopt = "menuone,noinsert,noselect,fuzzy,popup"
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.confirm = true

-- Behavior
vim.opt.autochdir = false
vim.opt.mouse = ""

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Miscellaneous
vim.opt.wildmode = "longest:full,full"
vim.opt.diffopt:append("linematch:60")
vim.opt.maxmempattern = 20000

-- Leader keys must be set before plugins load
vim.g.mapleader = " "
vim.g.maplocalleader = " "
