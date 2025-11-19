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

-- Buffers
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Close buffer" })

-- AUTOCOMMANDS

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Restore cursor to last position",
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, mark)
		end
	end,
})

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
	{ src = "https://github.com/stevearc/quicker.nvim" },
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

-- Register FzfLua as vim.ui.select backend
require("fzf-lua").register_ui_select()

require("nvim-web-devicons").setup()
require("oil").setup()

require("nvim-highlight-colors").setup({
	render = "background",
	enable_named_colors = true,
	enable_tailwind = true,
})

require("gitsigns").setup({
	signs = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged = {
		add = { text = "┃" },
		change = { text = "┃" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signs_staged_enable = true,
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
		use_focus = true,
	},
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
})

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

require("quicker").setup({
	keys = {
		{
			">",
			function()
				require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
			end,
			desc = "Expand quickfix context",
		},
		{
			"<",
			function()
				require("quicker").collapse()
			end,
			desc = "Collapse quickfix context",
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
		menu = {
			border = "rounded",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		},
	},
	appearance = {
		use_nvim_cmp_as_default = false,
		nerd_font_variant = "mono",
	},
})

-- FZF Keymaps
map("n", "<leader>f", "<cmd>FzfLua files<CR>", { desc = "Find files" })
map("n", "<leader>b", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })
map("n", "<leader>o", "<cmd>FzfLua oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>r", "<cmd>FzfLua resume<CR>", { desc = "Resume last search" })
map("n", "<leader>g", "<cmd>FzfLua live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>/", "<cmd>FzfLua grep_curbuf<CR>", { desc = "Grep current buffer" })
map("n", "<leader>*", "<cmd>FzfLua grep_cword<CR>", { desc = "Grep word under cursor" })
map("n", "<leader>gf", "<cmd>FzfLua git_files<CR>", { desc = "Git files" })
map("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Git status" })
map("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Git commits" })
map("n", "<leader>gb", "<cmd>FzfLua git_branches<CR>", { desc = "Git branches" })
map("n", "<leader>sd", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Document symbols" })
map("n", "<leader>sw", "<cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
map("n", "<leader>dd", "<cmd>FzfLua diagnostics_document<CR>", { desc = "Document diagnostics" })
map("n", "<leader>dw", "<cmd>FzfLua diagnostics_workspace<CR>", { desc = "Workspace diagnostics" })
map("n", "<leader>dq", function()
	vim.diagnostic.setqflist({ open = true })
end, { desc = "All diagnostics to quickfix" })
map("n", "<leader>h", "<cmd>FzfLua help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>k", "<cmd>FzfLua keymaps<CR>", { desc = "Keymaps" })
map("n", "<leader>m", "<cmd>FzfLua marks<CR>", { desc = "Marks" })
map("n", "<leader>j", "<cmd>FzfLua jumps<CR>", { desc = "Jumps" })
map("n", "<leader>c", "<cmd>FzfLua colorschemes<CR>", { desc = "Colorschemes" })

-- Other Keymaps
map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Undo tree" })
map("n", "<leader>F", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
map("n", "<leader>q", function()
	require("quicker").toggle()
end, { desc = "Toggle quickfix" })
map("n", "<leader>l", function()
	require("quicker").toggle({ loclist = true })
end, { desc = "Toggle loclist" })

-- LSP
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
	"bashls",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }
		local fzf = require("fzf-lua")

		vim.keymap.set("n", "gd", function()
			fzf.lsp_definitions({ jump1 = true })
		end, opts)
		vim.keymap.set("n", "gr", fzf.lsp_references, opts)
		vim.keymap.set("n", "gi", function()
			fzf.lsp_implementations({ jump_to_single_result = true })
		end, opts)
		vim.keymap.set("n", "gt", function()
			fzf.lsp_typedefs({ jump_to_single_result = true })
		end, opts)
		vim.keymap.set("n", "<leader>ca", fzf.lsp_code_actions, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
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
		ensure_installed = {},
		auto_install = false,
		highlight = { enable = true },
		indent = { enable = true },
	})
else
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

pcall(vim.cmd.colorscheme, "rose-pine")

local function apply_transparency()
	vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
end

local function apply_blink_highlights()
	local colors = require("rose-pine.palette")

	vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = colors.highlight_med })
	vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = colors.highlight_med, fg = colors.text })
	vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "NONE" })
	vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = colors.highlight_med })
	vim.api.nvim_set_hl(0, "BlinkCmpKind", { fg = colors.iris })
	vim.api.nvim_set_hl(0, "BlinkCmpKindText", { fg = colors.text })
	vim.api.nvim_set_hl(0, "BlinkCmpKindMethod", { fg = colors.foam })
	vim.api.nvim_set_hl(0, "BlinkCmpKindFunction", { fg = colors.foam })
	vim.api.nvim_set_hl(0, "BlinkCmpKindConstructor", { fg = colors.gold })
	vim.api.nvim_set_hl(0, "BlinkCmpKindField", { fg = colors.rose })
	vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = colors.text })
	vim.api.nvim_set_hl(0, "BlinkCmpKindClass", { fg = colors.gold })
	vim.api.nvim_set_hl(0, "BlinkCmpKindInterface", { fg = colors.gold })
	vim.api.nvim_set_hl(0, "BlinkCmpKindModule", { fg = colors.iris })
	vim.api.nvim_set_hl(0, "BlinkCmpKindProperty", { fg = colors.rose })
	vim.api.nvim_set_hl(0, "BlinkCmpKindKeyword", { fg = colors.pine })
	vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = colors.love })
	vim.api.nvim_set_hl(0, "BlinkCmpKindColor", { fg = colors.rose })
	vim.api.nvim_set_hl(0, "BlinkCmpKindFile", { fg = colors.text })
	vim.api.nvim_set_hl(0, "BlinkCmpKindFolder", { fg = colors.foam })
	vim.api.nvim_set_hl(0, "BlinkCmpKindConstant", { fg = colors.gold })
	vim.api.nvim_set_hl(0, "BlinkCmpKindOperator", { fg = colors.subtle })
end

apply_transparency()
apply_blink_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		apply_transparency()
		apply_blink_highlights()
	end,
})
