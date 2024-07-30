vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.opt.updatetime = 50

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for.
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing operations.
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent.
vim.opt.expandtab = true -- Convert tabs to spaces.
vim.opt.smartindent = true -- Automatically indent new lines.

vim.opt.wrap = false
vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.swapfile = false -- Disable swap file creation.
vim.opt.backup = false -- Disable backup file creation.
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir' -- Set the directory for undo files.
vim.opt.undofile = true -- Enable persistent undo.

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.signcolumn = 'yes'
