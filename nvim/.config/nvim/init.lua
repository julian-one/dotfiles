-- Core Settings
vim.cmd([[set mouse=]])       -- Disable mouse support
vim.opt.winborder = "rounded" -- Rounded window borders
vim.opt.hlsearch = false      -- Don't highlight search results
vim.opt.tabstop = 2           -- Tab width
vim.opt.cursorcolumn = false  -- Don't highlight cursor column
vim.opt.ignorecase = true     -- Case insensitive search
vim.opt.shiftwidth = 2        -- Indentation width
vim.opt.smartindent = true    -- Smart auto-indentation
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.termguicolors = true  -- Enable 24-bit RGB colors
vim.opt.undofile = true       -- Persistent undo history
vim.opt.signcolumn = "yes"    -- Always show sign column

-- Key Mappings Setup
local map = vim.keymap.set
vim.g.mapleader = " " -- Set leader key to space

-- File Operations
map('n', '<leader>o', ':update<CR> :source<CR>')     -- Save and source file
map('n', '<leader>w', ':write<CR>')                  -- Save file
map('n', '<leader>q', ':quit<CR>')                   -- Quit
map('n', '<leader>v', ':e $MYVIMRC<CR>')             -- Edit vimrc

-- System Integration
map({ 'n', 'v' }, '<leader>y', '"+y') -- Yank to system clipboard
map({ 'n', 'v' }, '<leader>d', '"+d') -- Delete to system clipboard
map({ 'n', 'v' }, '<leader>c', '1z=') -- Quick spell correction (first suggestion)

-- Plugin Management
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },                               -- Colorscheme
	{ src = "https://github.com/stevearc/oil.nvim" },                                -- File explorer
	{ src = "https://github.com/echasnovski/mini.pick" },                            -- Fuzzy finder
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }, -- Syntax highlighting
	{ src = 'https://github.com/neovim/nvim-lspconfig' },                            -- LSP configurations
	{ src = "https://github.com/mason-org/mason.nvim" },                             -- LSP server installer
	{ src = 'https://github.com/NvChad/showkeys',                 opt = true },      -- Show keypresses
	{ src = "https://github.com/Saghen/blink.cmp" },                                 -- Completion engine
	{ src = "https://github.com/folke/trouble.nvim" },                               -- Diagnostic list
})

-- Plugin Setup
require "mason".setup()                              -- Initialize Mason for LSP management
require "showkeys".setup({ position = "top-right" }) -- Show keypresses in top-right
require "mini.pick".setup()                          -- Initialize fuzzy finder
require "oil".setup()                                -- Initialize file explorer
require "trouble".setup()                            -- Initialize trouble diagnostics

-- Completion Setup (blink.cmp)
require("blink.cmp").setup({
	keymap = { preset = 'default' },                    -- Use default keymaps
	sources = {
		default = { 'lsp', 'path', 'buffer' } -- Enable LSP, path, and buffer completion
	},
	signature = { enabled = true },                     -- Show function signatures
	completion = {
		documentation = { auto_show = true }            -- Show documentation for completion items
	},
	fuzzy = {
		implementation = "lua" -- Use Lua implementation (no Rust dependency)
	}
})

-- Navigation & Search Keymaps
map('n', '<leader>f', ":Pick files<CR>")  -- Fuzzy find files
map('n', '<leader>g', ":Pick grep_live<CR>") -- Live grep text in files
map('n', '<leader>b', ":Pick buffers<CR>") -- Show open buffers
map('n', '<leader>h', ":Pick help<CR>")   -- Fuzzy find help
map('n', '<leader>e', ":Oil<CR>")         -- Open file explorer

-- LSP Keymaps (standard keymaps that many expect)
map('n', 'gd', vim.lsp.buf.definition)      -- Go to definition
map('n', 'gr', vim.lsp.buf.references)      -- Show references (overrides default grr)
map('n', 'gi', vim.lsp.buf.implementation)  -- Go to implementation (overrides default gri)
map('n', 'gt', vim.lsp.buf.type_definition) -- Go to type definition (overrides default grt)
map('n', '<leader>ca', vim.lsp.buf.code_action) -- Code actions (additional to default gra)
map('n', '<leader>rn', vim.lsp.buf.rename)  -- Rename symbol (additional to default grn)
map('n', '<leader>lf', vim.lsp.buf.format)  -- Format buffer with LSP

-- LSP Configuration
-- Enable LSP servers for full-stack development (Go backend + Svelte frontend on GCP)
vim.lsp.enable({
	"lua_ls",      -- Lua Language Server
	"gopls",       -- Go Language Server
	"svelte",      -- Svelte Language Server
	"ts_ls",       -- TypeScript/JavaScript Language Server
	"tailwindcss", -- TailwindCSS Language Server
	"templ",       -- Templ Language Server
	"emmetls",     -- Emmet Language Server
	"jsonls",      -- JSON Language Server
	"yamlls",      -- YAML Language Server
	"dockerls",    -- Docker Language Server
	"html",        -- HTML Language Server
	"cssls"        -- CSS Language Server
})

-- Trouble Diagnostic Keymaps (after LSP setup)
map('n', '<leader>xx', ':Trouble diagnostics toggle<CR>') -- Toggle trouble diagnostics
map('n', '<leader>xd', ':Trouble diagnostics toggle filter.buf=0<CR>') -- Document diagnostics
map('n', '<leader>xs', ':Trouble symbols toggle focus=false<CR>') -- Document symbols
map('n', '<leader>xl', ':Trouble loclist toggle<CR>') -- Location list
map('n', '<leader>xq', ':Trouble qflist toggle<CR>') -- Quickfix list

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

