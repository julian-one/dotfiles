vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.mouse = ''

-- ---------------------------------------------------------------------------
-- Appearance
-- ---------------------------------------------------------------------------
vim.o.number = true
vim.o.relativenumber = true

vim.o.cursorline = true

vim.o.signcolumn = 'yes'

vim.o.winborder = 'rounded'

vim.o.wrap = false

vim.o.scrolloff = 10
vim.o.sidescrolloff = 10

-- ---------------------------------------------------------------------------
-- Folding
-- ---------------------------------------------------------------------------
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.o.foldtext = ''

vim.o.foldlevelstart = 99

-- ---------------------------------------------------------------------------
-- Searching
-- ---------------------------------------------------------------------------
vim.o.hlsearch = false

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.inccommand = 'split'

-- ---------------------------------------------------------------------------
-- Completion
-- ---------------------------------------------------------------------------
vim.o.completeopt = 'menu,menuone,popup,noselect'

vim.opt.wildoptions:append 'fuzzy'

-- ---------------------------------------------------------------------------
-- Files
-- ---------------------------------------------------------------------------
vim.o.swapfile = false

vim.o.undofile = true

-- ---------------------------------------------------------------------------
-- Timing
-- ---------------------------------------------------------------------------
vim.o.updatetime = 200

vim.o.timeoutlen = 500

vim.o.ttimeoutlen = 0

-- ---------------------------------------------------------------------------
-- Diagnostics
-- ---------------------------------------------------------------------------
vim.diagnostic.config { severity_sort = true, virtual_text = true }
