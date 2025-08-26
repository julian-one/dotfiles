-- ============================================================================
-- NEOVIM CONFIGURATION
-- ============================================================================

-- ============================================================================
-- CORE SETTINGS
-- ============================================================================

-- Mouse
vim.opt.mouse = ""

-- Leader Keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ============================================================================
-- VISUAL & UI SETTINGS
-- ============================================================================

-- Line Numbers & Cursor
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

-- Display & Layout
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.matchtime = 2

-- Colors & Transparency
vim.opt.termguicolors = true
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.winborder = "rounded"

-- Command Line & UI
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.pumheight = 10

-- Concealing & Syntax
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.synmaxcol = 300

-- Performance
vim.opt.lazyredraw = true
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- ============================================================================
-- EDITING & INDENTATION
-- ============================================================================

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- ============================================================================
-- SEARCH SETTINGS
-- ============================================================================

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- ============================================================================
-- FILE HANDLING & BACKUP
-- ============================================================================

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.autoread = true
vim.opt.autowrite = false

-- ============================================================================
-- PERFORMANCE & TIMING
-- ============================================================================

vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0

-- ============================================================================
-- COMPLETION & BEHAVIOR
-- ============================================================================

vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"

-- Cursor settings
vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- ============================================================================
-- SPELL CHECKING
-- ============================================================================

vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- ============================================================================
-- WINDOW BEHAVIOR
-- ============================================================================

vim.opt.splitbelow = true
vim.opt.splitright = true

-- ============================================================================
-- FOLDING CONFIGURATION
-- ============================================================================

vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99

-- LSP-based folding
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		for _, client in pairs(clients) do
			if client.server_capabilities.foldingRangeProvider then
				vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
				break
			end
		end
	end,
})

-- ============================================================================
-- KEY MAPPINGS
-- ============================================================================

local map = vim.keymap.set

-- File Operations
map("n", "<leader>o", ":update<CR> :source<CR>", { desc = "Save and source file" })
map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
map("n", "<leader>v", ":e $MYVIMRC<CR>", { desc = "Edit vimrc" })

-- System Integration
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>z", "1z=", { desc = "Quick spell correction" })
map("n", "<leader>s", ":set spell!<CR>", { desc = "Toggle spell check" })

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

-- Window Management
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })

-- Line Movement
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Visual Mode Indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- ============================================================================
-- PLUGIN MANAGEMENT
-- ============================================================================

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/echasnovski/mini.statusline" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

-- ============================================================================
-- PLUGIN CONFIGURATION
-- ============================================================================

-- Core Plugin Setup
require("mason").setup()
require("mini.pick").setup()
require("mini.statusline").setup()
require("oil").setup()
require("trouble").setup()
require("gitsigns").setup()

-- Code Formatting (Conform)
require("conform").setup({
	notify_on_error = false,
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 3000,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofumpt", "golines" },
		templ = { "templ" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
	},
})

-- Completion Engine (Blink)
require("blink.cmp").setup({
	keymap = { preset = "default" },
	sources = {
		default = { "lsp", "path", "buffer" },
	},
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true },
	},
	fuzzy = {
		implementation = "lua",
	},
})

-- ============================================================================
-- PLUGIN KEYMAPS
-- ============================================================================

-- File Navigation & Search
map("n", "<leader>f", ":Pick files<CR>", { desc = "Fuzzy find files" })
map("n", "<leader>g", ":Pick grep_live<CR>", { desc = "Live grep search" })
map("n", "<leader>b", ":Pick buffers<CR>", { desc = "Show open buffers" })
map("n", "<leader>h", ":Pick help<CR>", { desc = "Fuzzy find help" })
map("n", "<leader>e", ":Oil<CR>", { desc = "Open file explorer" })
map("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Toggle undo tree" })

-- Trouble Diagnostics
map("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", { desc = "Toggle diagnostics" })
map("n", "<leader>xd", ":Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Buffer diagnostics" })
map("n", "<leader>xs", ":Trouble symbols toggle focus=false<CR>", { desc = "Document symbols" })
map("n", "<leader>xl", ":Trouble loclist toggle<CR>", { desc = "Location list" })
map("n", "<leader>xq", ":Trouble qflist toggle<CR>", { desc = "Quickfix list" })

-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================

-- LSP Servers
vim.lsp.enable({
	"lua_ls",
	"gopls",
	"svelte",
	"ts_ls",
	"tailwindcss",
	"templ",
	"emmetls",
	"jsonls",
	"yamlls",
	"dockerls",
	"html",
	"cssls",
})

-- LSP Keymaps (Auto-configured on LSP attach)
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		-- Navigation
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		-- Information
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

		-- Code Actions
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		-- Diagnostics
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
	end,
})

-- LSP UI Configuration
vim.diagnostic.config({
	virtual_text = { prefix = "●" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.INFO] = "󰋽",
			[vim.diagnostic.severity.HINT] = "󰌶",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- ============================================================================
-- TREESITTER CONFIGURATION
-- ============================================================================

require("nvim-treesitter").setup({
	highlight = { enable = true },
	ensure_installed = {
		"lua",
		"go",
		"javascript",
		"typescript",
		"svelte",
		"html",
		"css",
		"json",
		"yaml",
		"docker",
		"templ",
		"bash",
		"markdown",
	},
})

-- ============================================================================
-- COLORSCHEME
-- ============================================================================

require("vague").setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
