vim.opt.mouse = ""

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

-- Completions
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.pumheight = 10
vim.opt.pumblend = 10

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'

-- Spell
vim.opt.spell = true
vim.opt.spelllang = "en"
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"


-- Undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
