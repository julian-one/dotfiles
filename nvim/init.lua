-- Basics
vim.opt.number = true -- Line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.wrap = false -- Don't wrap lines
vim.opt.scrolloff = 10 -- Keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- Keep 10 columns left/right of cursor

-- Indentation
vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

-- Search
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase in search
vim.opt.hlsearch = false -- Don't highlight search results
vim.opt.incsearch = true -- Show matches as you type
vim.opt.inccommand = "split" -- Live preview of substitutions

-- Visual
vim.g.have_nerd_font = true -- Enable nerd font icons
vim.opt.winborder = "rounded" -- Rounded window borders
vim.opt.breakindent = true -- Maintain indent on wrap
vim.opt.termguicolors = true -- Enable 24-bit colors
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.colorcolumn = "100" -- Show column at 100 characters
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.cmdheight = 1 -- Command line height
vim.opt.completeopt = "menuone,noinsert,noselect" -- Completion options
vim.opt.showmode = true -- Show mode in command line
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency
vim.opt.conceallevel = 0 -- Don't hide markup
vim.opt.concealcursor = "" -- Don't hide cursor line markup
vim.opt.synmaxcol = 300 -- Syntax highlighting limit
vim.opt.lazyredraw = true -- Don't redraw while executing macros

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

-- File handling
vim.opt.backup = false -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before writing
vim.opt.swapfile = false -- Don't create swap files
vim.opt.undofile = true -- Persistent undo
vim.opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- Key timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = false -- Don't auto save
vim.opt.confirm = true -- Confirm before exiting unsaved

-- Behavior
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- No error bells
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.path:append("**") -- Include subdirectories in search
vim.opt.selection = "exclusive" -- Selection behavior
vim.opt.mouse = "" -- Enable mouse support
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.encoding = "UTF-8" -- Set encoding

-- Folding
vim.opt.foldmethod = "expr" -- Use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Start with all folds open

-- Splits
vim.opt.splitbelow = true -- Horizontal splits go below
vim.opt.splitright = true -- Vertical splits go right

-- Miscellaneous
vim.opt.wildmenu = true -- Tab completion
vim.opt.wildmode = "longest:full,full" -- Complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- Improve diff display
vim.opt.redrawtime = 10000 -- Increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- Increase max memory

-- Key mappings
vim.g.mapleader = " " -- Set leader key to space
vim.g.maplocalleader = " " -- Set local leader key

vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.keymap.set("n", "]q", "<cmd>cnext<cr>zz", { desc = "Next quickfix item" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>zz", { desc = "Previous quickfix item" })
vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "Close quickfix list" })

vim.keymap.set(
	"n",
	"<leader>xx",
	"<cmd>lua vim.diagnostic.setqflist()<cr><cmd>copen<cr>",
	{ desc = "Project Diagnostics (Quickfix)" }
)
vim.keymap.set(
	"n",
	"<leader>xX",
	"<cmd>lua vim.diagnostic.setloclist()<cr><cmd>lopen<cr>",
	{ desc = "Buffer Diagnostics (Location list)" }
)

-- Diagnostics
local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	virtual_lines = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
		focusable = true,
		style = "minimal",
	},
})

-- Plugins
vim.pack.add({
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	{ src = "https://github.com/fredrikaverpil/godoc.nvim" },
	{ src = "https://github.com/NvChad/nvim-colorizer.lua" },
	{ src = "https://github.com/vague-theme/vague.nvim" },
})

-- Fidget
require("fidget").setup({})

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
		"ts_ls",
		"prettierd",
		"eslint_d",
		"gopls",
		"goimports",
		"gofumpt",
		"golines",
		"golangci-lint",
		"svelte",
		"tailwindcss",
		"emmet_ls",
		"html",
		"cssls",
		"templ",
		"jsonls",
		"yamlls",
		"dockerls",
		"bashls",
		"sql-formatter",
	},
})

-- Autocomplete
require("blink.cmp").setup({
	cmdline = { enabled = true },
	keymap = {
		preset = "default",
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = {
		menu = {
			draw = {
				columns = { { "kind" }, { "label", "label_description" } },
			},
		},
		documentation = { auto_show = true },
		ghost_text = { enabled = false },
	},
	signature = { enabled = true },
	fuzzy = { implementation = "prefer_rust" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			lsp = { fallbacks = { "buffer" } },
			buffer = {
				min_keyword_length = 3,
				max_items = 5,
			},
		},
	},
})

-- Formatting
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofumpt", "golines" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		markdown = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		sql = { "sql_formatter" },
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 2000,
	},
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
	notify_no_formatters = true,
})

-- Undo tree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "[U]ndo tree" })

-- File explorer
require("oil").setup({
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
})
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File [E]xplorer" })

-- Fuzzy finder
require("telescope").setup({
	defaults = {
		preview = { treesitter = true },
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = {
			"", -- top
			"", -- right
			"", -- bottom
			"", -- left
			"", -- top-left
			"", -- top-right
			"", -- bottom-right
			"", -- bottom-left
		},
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "[S]earch [M]an pages" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "[S]earch [C]ommands" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- Git signs
require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
})
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "[G]it [F]iles" })

-- Godoc
require("godoc").setup({
	picker = { type = "telescope" },
	window = { type = "vsplit" },
	adapters = {
		{
			name = "go",
			opts = {
				get_syntax_info = function()
					return { filetype = "godoc", language = "godoc" }
				end,
			},
		},
	},
})
vim.keymap.set("n", "<leader>gd", "<cmd>GoDoc<cr>", { desc = "[G]o [D]oc" })

-- Which key?
require("which-key").setup({
	delay = 0,
	icons = {
		mappings = true,
	},
	spec = {
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>d", group = "[D]iagnostics" },
		{ "<leader>g", group = "[G]it" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>x", group = "[X] Quickfix / List" },
	},
})

-- Treesitter
require("nvim-treesitter").setup()

require("nvim-treesitter.parsers").godoc = {
	tier = 0,
	install_info = {
		url = "https://github.com/fredrikaverpil/tree-sitter-godoc",
		revision = "main",
	},
}

vim.treesitter.language.register("godoc", "godoc")

require("nvim-treesitter").install({
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
	"svelte",
	"typescript",
	"javascript",
	"html",
	"css",
	"go",
	"gomod",
	"gosum",
	"yaml",
})

require("treesitter-context").setup({
	max_lines = 3,
	zindex = 20,
})

-- Colors!
require("colorizer").setup({})

require("vague").setup({
	transparent = true,
})
vim.cmd("colorscheme vague")

-- Load additional modules
require("autocmds")
require("terminal")
require("clean")
