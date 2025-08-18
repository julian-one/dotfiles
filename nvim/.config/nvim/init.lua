vim.opt.mouse = ""

-- Visual Settings
vim.opt.number = true                              -- Line numbers
vim.opt.relativenumber = true                      -- Relative line numbers
vim.opt.cursorline = true                          -- Highlight current line
vim.opt.cursorcolumn = false                       -- Don't highlight cursor column
vim.opt.wrap = false                               -- Don't wrap lines
vim.opt.scrolloff = 10                             -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 8                          -- Keep 8 columns left/right of cursor
vim.opt.termguicolors = true                       -- Enable 24-bit RGB colors
vim.opt.signcolumn = "yes"                         -- Always show sign column
vim.opt.colorcolumn = "100"                        -- Show column at 100 characters
vim.opt.showmatch = true                           -- Highlight matching brackets
vim.opt.matchtime = 2                              -- How long to show matching bracket
vim.opt.cmdheight = 1                              -- Command line height
vim.opt.showmode = false                           -- Don't show mode in command line
vim.opt.pumheight = 10                             -- Popup menu height
vim.opt.pumblend = 10                              -- Popup menu transparency
vim.opt.winblend = 0                               -- Floating window transparency
vim.opt.winborder = "rounded"                      -- Rounded window borders
vim.opt.conceallevel = 0                           -- Don't hide markup
vim.opt.concealcursor = ""                         -- Don't hide cursor line markup
vim.opt.lazyredraw = true                          -- Don't redraw during macros
vim.opt.synmaxcol = 300                            -- Syntax highlighting limit

-- Indentation
vim.opt.tabstop = 2                                -- Tab width
vim.opt.shiftwidth = 2                             -- Indent width
vim.opt.softtabstop = 2                            -- Soft tab stop
vim.opt.expandtab = true                           -- Use spaces instead of tabs
vim.opt.smartindent = true                         -- Smart auto-indenting
vim.opt.autoindent = true                          -- Copy indent from current line

-- Search Settings
vim.opt.ignorecase = true                          -- Case insensitive search
vim.opt.smartcase = true                           -- Case sensitive if uppercase in search
vim.opt.hlsearch = false                           -- Don't highlight search results
vim.opt.incsearch = true                           -- Show matches as you type

-- File Handling
vim.opt.backup = false                             -- Don't create backup files
vim.opt.writebackup = false                        -- Don't create backup before writing
vim.opt.swapfile = false                           -- Don't create swap files
vim.opt.undofile = true                            -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")  -- Undo directory
vim.opt.autoread = true                            -- Auto reload files changed outside vim
vim.opt.autowrite = false                          -- Don't auto save

-- Performance
vim.opt.updatetime = 300                           -- Faster completion
vim.opt.timeoutlen = 500                           -- Key timeout duration
vim.opt.ttimeoutlen = 0                            -- Key code timeout

-- Completion
vim.opt.completeopt = "menuone,noinsert,noselect"  -- Completion options

-- Behavior Settings
vim.opt.hidden = true                              -- Allow hidden buffers
vim.opt.errorbells = false                         -- No error bells
vim.opt.backspace = "indent,eol,start"             -- Better backspace behavior
vim.opt.autochdir = false                          -- Don't auto change directory
vim.opt.iskeyword:append("-")                      -- Treat dash as part of word
vim.opt.path:append("**")                          -- Include subdirectories in search
vim.opt.selection = "exclusive"                    -- Selection behavior
vim.opt.clipboard:append("unnamedplus")            -- Use system clipboard
vim.opt.modifiable = true                          -- Allow buffer modifications
vim.opt.encoding = "UTF-8"                         -- Set encoding

-- Cursor Settings
vim.opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Split Behavior
vim.opt.splitbelow = true                          -- Horizontal splits go below
vim.opt.splitright = true                          -- Vertical splits go right

-- Folding
vim.opt.foldmethod = "expr"                        -- Use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99                             -- Start with all folds open

-- Key Mappings Setup
local map = vim.keymap.set
vim.g.mapleader = " "      -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key

-- File Operations
map('n', '<leader>o', ':update<CR> :source<CR>') -- Save and source file
map('n', '<leader>w', ':write<CR>')              -- Save file
map('n', '<leader>q', ':quit<CR>')               -- Quit
map('n', '<leader>v', ':e $MYVIMRC<CR>')         -- Edit vimrc

-- System Integration
map({ 'n', 'v' }, '<leader>y', '"+y') -- Yank to system clipboard
map({ 'n', 'v' }, '<leader>d', '"+d') -- Delete to system clipboard
map({ 'n', 'v' }, '<leader>c', '1z=') -- Quick spell correction (first suggestion)

-- Search & Navigation
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window Splitting 
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })

-- Move Lines
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better Visual Mode Indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Plugin Management
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },                               -- Colorscheme
	{ src = "https://github.com/stevearc/oil.nvim" },                                -- File explorer
	{ src = "https://github.com/echasnovski/mini.pick" },                            -- Fuzzy finder
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }, -- Syntax highlighting
	{ src = 'https://github.com/neovim/nvim-lspconfig' },                            -- LSP configurations
	{ src = "https://github.com/mason-org/mason.nvim" },                             -- LSP server installer
	{ src = "https://github.com/Saghen/blink.cmp" },                                 -- Completion engine
	{ src = "https://github.com/folke/trouble.nvim" },                               -- Diagnostic list
	{ src = "https://github.com/mbbill/undotree" },                                  -- Undo tree visualizer
})

-- Plugin Setup
require "mason".setup()                              -- Initialize Mason for LSP management
require "mini.pick".setup()                          -- Initialize fuzzy finder
require "oil".setup()                                -- Initialize file explorer
require "trouble".setup()                            -- Initialize trouble diagnostics

-- Completion Setup (blink.cmp)
require("blink.cmp").setup({
	keymap = { preset = 'default' },      -- Use default keymaps
	sources = {
		default = { 'lsp', 'path', 'buffer' } -- Enable LSP, path, and buffer completion
	},
	signature = { enabled = true },       -- Show function signatures
	completion = {
		documentation = { auto_show = true } -- Show documentation for completion items
	},
	fuzzy = {
		implementation = "lua" -- Use Lua implementation (no Rust dependency)
	}
})

-- Navigation & Search Keymaps
map('n', '<leader>f', ":Pick files<CR>")     -- Fuzzy find files
map('n', '<leader>g', ":Pick grep_live<CR>") -- Live grep text in files
map('n', '<leader>b', ":Pick buffers<CR>")   -- Show open buffers
map('n', '<leader>h', ":Pick help<CR>")      -- Fuzzy find help
map('n', '<leader>e', ":Oil<CR>")            -- Open file explorer
map('n', '<leader>u', ":UndotreeToggle<CR>")     -- Toggle undo tree

-- LSP Configuration and Keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local opts = {buffer = event.buf}

    -- Navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    -- Information
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- Code actions
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    -- Diagnostics
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
  end,
})

-- Better LSP UI
vim.diagnostic.config({
  virtual_text = { prefix = '●' },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚",
      [vim.diagnostic.severity.WARN] = "󰀪",
      [vim.diagnostic.severity.INFO] = "󰋽",
      [vim.diagnostic.severity.HINT] = "󰌶",
    }
  }
})

-- LSP Configuration
-- Enable LSP servers for full-stack development (Go backend + Svelte frontend on GCP)
vim.lsp.enable({
	"lua_ls",     -- Lua Language Server
	"gopls",      -- Go Language Server
	"svelte",     -- Svelte Language Server
	"ts_ls",      -- TypeScript/JavaScript Language Server
	"tailwindcss", -- TailwindCSS Language Server
	"templ",      -- Templ Language Server
	"emmetls",    -- Emmet Language Server
	"jsonls",     -- JSON Language Server
	"yamlls",     -- YAML Language Server
	"dockerls",   -- Docker Language Server
	"html",       -- HTML Language Server
	"cssls"       -- CSS Language Server
})

-- Trouble Diagnostic Keymaps (after LSP setup)
map('n', '<leader>xx', ':Trouble diagnostics toggle<CR>')              -- Toggle trouble diagnostics
map('n', '<leader>xd', ':Trouble diagnostics toggle filter.buf=0<CR>') -- Document diagnostics
map('n', '<leader>xs', ':Trouble symbols toggle focus=false<CR>')      -- Document symbols
map('n', '<leader>xl', ':Trouble loclist toggle<CR>')                  -- Location list
map('n', '<leader>xq', ':Trouble qflist toggle<CR>')                   -- Quickfix list

-- Treesitter Configuration
require('nvim-treesitter').setup({
	highlight = { enable = true },
	ensure_installed = {
		"lua", "go", "javascript", "typescript", "svelte", "html", "css",
		"json", "yaml", "docker", "templ", "bash", "markdown"
	},
	auto_install = true,
})

-- Color Scheme Configuration
require "vague".setup({ transparent = true }) -- Setup vague theme with transparency
vim.cmd("colorscheme vague")                  -- Apply the colorscheme
vim.cmd(":hi statusline guibg=NONE")          -- Make statusline background transparent
