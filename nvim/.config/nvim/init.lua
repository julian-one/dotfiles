-- OPTIONS

-- Leader 
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI
vim.opt.winborder = "rounded"
vim.opt.showmode = true
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.termguicolors = true
vim.opt.scrolloff = 10

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Files & Backups
vim.opt.undofile = true
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

-- Timing
vim.opt.updatetime = 300

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99

-- KEYMAPS

local map = vim.keymap.set

-- File Operations
map("n", "<leader>v", ":e $MYVIMRC<CR>", { desc = "Edit vimrc" })

-- System Integration
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map({ "n", "v" }, "<leader>z", "1z=", { desc = "Quick spell correction" })

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

-- Visual Mode Indenting
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Tab Navigation
map("n", "<leader>1", "1gt", { desc = "Go to tab 1" })
map("n", "<leader>2", "2gt", { desc = "Go to tab 2" })
map("n", "<leader>3", "3gt", { desc = "Go to tab 3" })
map("n", "<leader>4", "4gt", { desc = "Go to tab 4" })
map("n", "<leader>5", "5gt", { desc = "Go to tab 5" })
map("n", "<leader>6", "6gt", { desc = "Go to tab 6" })
map("n", "<leader>7", "7gt", { desc = "Go to tab 7" })
map("n", "<leader>8", "8gt", { desc = "Go to tab 8" })

-- Text Manipulation
map("n", "J", "mzJ`z", { desc = "Join line (keep cursor position)" })
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Buffer Management
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })

-- AUTOCOMMANDS

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restore cursor to last position when opening file",
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

-- LSP-based folding
vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup,
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

-- PLUGINS

vim.pack.add({
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/Saghen/blink.cmp", version = "v0.*" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/brenoprata10/nvim-highlight-colors" },
})

-- FZF
require("fzf-lua").setup({
	winopts = {
		height = 0.85,
		width = 0.80,
		border = "rounded",
		preview = {
			horizontal = "right:60%",
			border = "rounded",
			scrollbar = "float",
		},
	},
	files = {
		prompt = "Files❯ ",
		file_icons = true,
		git_icons = false,
		color_icons = true,
	},
	grep = {
		prompt = "Grep❯ ",
		rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
	},
	git = {
		files = { prompt = "GitFiles❯ " },
		status = { prompt = "GitStatus❯ " },
		commits = { prompt = "Commits❯ " },
		branches = { prompt = "Branches❯ " },
	},
	lsp = {
		prompt_postfix = "❯ ",
		symbols = {
			symbol_style = 1,
		},
	},
})

-- Oil
require("oil").setup()

-- Color Preview
require("nvim-highlight-colors").setup({
	render = "background", -- 'background' | 'foreground' | 'virtual'
	enable_named_colors = true,
	enable_tailwind = true,
})

-- Git Signs
require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

-- Conform
require("conform").setup({
	notify_on_error = false,
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofumpt", "golines" },
		templ = { "templ" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		svelte = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		sql = { "sql-formatter" },
	},
	formatters = {
		["sql-formatter"] = {
			command = "sql-formatter",
			args = {
				"--language",
				"bigquery",
				"--config",
				'{"keywordCase":"upper","dataTypeCase":"upper","linesBetweenQueries":1,"newlineBeforeSemicolon":false,"indentStyle":"standard","tabWidth":2,"logicalOperatorNewline":"before"}',
			},
			stdin = true,
		},
	},
})

-- Blink Completion
require("blink.cmp").setup({
	keymap = { preset = "default" },
	sources = {
		default = { "lsp", "path", "buffer" },
	},
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true },
	},
})

-- FZF Keymaps
-- Files & Buffers
map("n", "<leader>f", "<cmd>FzfLua files<CR>", { desc = "Find files" })
map("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })
map("n", "<leader>o", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>r", "<cmd>FzfLua resume<CR>", { desc = "Resume last search" })

-- Search
map("n", "<leader>g", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>/", "<cmd>FzfLua grep_curbuf<CR>", { desc = "Grep current buffer" })
map("n", "<leader>*", "<cmd>FzfLua grep_cword<CR>", { desc = "Grep word under cursor" })
map("n", "<leader>l", "<cmd>FzfLua blines<CR>", { desc = "Buffer lines" })

-- Git
map("n", "<leader>gf", "<cmd>FzfLua git_files<CR>", { desc = "Git files" })
map("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Git status" })
map("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "Git branches" })

-- LSP (active in LSP buffers)
map("n", "<leader>sd", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<leader>sw", "<cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })

-- Diagnostics
map("n", "<leader>dd", "<cmd>FzfLua diagnostics_document<CR>", { desc = "Document diagnostics" })
map("n", "<leader>dw", "<cmd>FzfLua diagnostics_workspace<CR>", { desc = "Workspace diagnostics" })

-- Other
map("n", "<leader>h", "<cmd>FzfLua help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>k", "<cmd>FzfLua keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>m", "<cmd>FzfLua marks<CR>", { desc = "Marks" })
map("n", "<leader>j", "<cmd>FzfLua jumps<CR>", { desc = "Jumps" })
map("n", "<leader>c", "<cmd>FzfLua colorschemes<CR>", { desc = "Colorschemes" })

-- Plugin Keymaps
map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Undo tree" })
map("n", "<leader>F", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, { desc = "Format buffer" })

-- LSP

-- Configure LSP servers BEFORE enabling them
-- Emmet configuration
vim.lsp.config("emmet_ls", {
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"svelte",
	},
})

vim.lsp.config("svelte", {
	handlers = {
		["workspace/inlayHint/refresh"] = function()
			return vim.NIL
		end,
		["workspace/semanticTokens/refresh"] = function()
			return vim.NIL
		end,
	},
})

-- Enable LSP servers (install manually via package manager)
-- Fedora: dnf install lua-language-server gopls nodejs-typescript-language-server
-- macOS: brew install lua-language-server gopls typescript-language-server
vim.lsp.enable({
	"lua_ls",
	"gopls",
	"svelte",
	"ts_ls",
	"tailwindcss",
	"templ",
	"emmet_ls",
	"jsonls",
	"yamlls",
	"dockerls",
	"html",
	"cssls",
})

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }
		local fzf = require("fzf-lua")

		-- Use fzf-lua for LSP navigation
		vim.keymap.set("n", "gd", function() fzf.lsp_definitions({ jump1 = true }) end, opts)
		vim.keymap.set("n", "gr", fzf.lsp_references, opts)
		vim.keymap.set("n", "gi", function() fzf.lsp_implementations({ jump_to_single_result = true }) end, opts)
		vim.keymap.set("n", "gt", function() fzf.lsp_typedefs({ jump_to_single_result = true }) end, opts)

		-- Code actions and rename
		vim.keymap.set("n", "<leader>ca", fzf.lsp_code_actions, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		-- Diagnostics
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

		-- Standard LSP functions
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	end,
})

-- LSP UI
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

-- TREESITTER

local ts_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if ts_ok then
	ts_configs.setup({
		ensure_installed = {}, -- Install manually via :TSInstall
		auto_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
	})
else
	-- Fallback: enable treesitter manually for each buffer
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
			local buf = vim.api.nvim_get_current_buf()
			if vim.bo[buf].buftype == "" then
				pcall(vim.treesitter.start, buf)
			end
		end,
	})
end

-- COLORSCHEME

require("rose-pine").setup({
	variant = "main",
	dark_variant = "main",
	dim_inactive_windows = false,
	extend_background_behind_borders = true,
	styles = {
		bold = true,
		italic = false,
		transparency = true,
	},
})

-- Apply colorscheme
pcall(vim.cmd.colorscheme, "rose-pine")

-- Transparency helper function
local function apply_transparency()
	vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
end

-- Apply transparency immediately and on colorscheme changes
apply_transparency()
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = apply_transparency,
})
