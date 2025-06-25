vim.opt.mouse = ""

-- Appearance
vim.g.have_nerd_font = false
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 8
vim.opt.softtabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = false
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
