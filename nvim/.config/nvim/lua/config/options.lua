--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable true-color support
vim.o.termguicolors = true

-- Disable line wrapping: long lines stay on one line
vim.o.wrap = false

-- Indentation settings
vim.o.expandtab = false -- use real Tab characters, not spaces
vim.o.smartindent = true -- smart auto-indent in program files

-- Swap/backup/undo settings
vim.o.swapfile = false -- no swap files
vim.o.backup = false -- no backup files
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir" -- where to store undo history

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = ""

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false -- Disable persistent highlight of search matches
vim.o.incsearch = true -- Enable incremental search: show matches as you type

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
