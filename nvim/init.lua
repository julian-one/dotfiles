vim.g.mapleader = " " -- leader key
vim.g.maplocalleader = " " -- local leader key
vim.g.have_nerd_font = true -- enable nerd font icons
vim.opt.winborder = "rounded" -- rounded window borders
vim.opt.showmode = false -- dont show -- INSERT -- etc since lualine shows it
vim.opt.breakindent = true -- maintain indent on wrap
vim.opt.mouse = "" -- disable mouse
vim.o.confirm = true -- confirm before exiting unsaved
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.colorcolumn = "100" -- column guide at 100 chars
vim.opt.termguicolors = true -- enable 24-bit colors
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right
vim.opt.tabstop = 2 -- tab width
vim.opt.shiftwidth = 2 -- indent width
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- auto indent new lines
vim.opt.ignorecase = true -- ignore case in search
vim.opt.smartcase = true -- unless uppercase is used
vim.opt.hlsearch = false -- don't highlight search results
vim.opt.incsearch = true -- incremental search
vim.opt.inccommand = "split" -- live preview of substitutions
vim.opt.undofile = true -- persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 300 -- faster key sequences
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.wrap = false
vim.opt.foldlevel = 99 -- open all folds by default

-- undo local storage
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

-- :help vim.diagnostic.Opts
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	virtual_text = true,
	virtual_lines = false,
	jump = { float = true },
})

-- keymaps
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

require("autocmds")
require("terminal")

-- plugins
vim.pack.add({
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/stevearc/quicker.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
	{ src = "https://github.com/giuxtaposition/blink-cmp-copilot" },
	{ src = "https://github.com/rose-pine/neovim" },
})

require("fidget").setup({})
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

vim.lsp.config("gopls", {
	settings = {
		gopls = {
			hints = {
				rangeVariableTypes = true,
				parameterNames = true,
				constantValues = true,
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				functionTypeParameters = true,
			},
		},
	},
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			hint = {
				enable = true,
			},
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config("svelte", {
	settings = {
		typescript = {
			inlayHints = {
				parameterNames = { enabled = "all" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
		},
	},
})

vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.29.0-standalone-strict/all.json"] = {
					"/*.k8s.yaml",
					"/*.k8s.yml",
				},
			},
			validate = true,
			completion = true,
			hover = true,
		},
	},
})

-- copilot
require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

-- autocomplete
require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
	fuzzy = {
		prebuilt_binaries = {
			download = true,
			force_version = "v1.3.1",
		},
	},
	signature = { enabled = true },
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
		},
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "copilot" },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-cmp-copilot",
				score_offset = 100,
				async = true,
			},
		},
	},
})

-- formatting
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofumpt", "golines" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		markdown = { "prettierd" },
		svelte = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
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

-- undo tree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo tree" })

-- quickfix
require("quicker").setup()
vim.keymap.set("n", "<leader>q", function()
	require("quicker").toggle()
end, { desc = "Toggle quickfix" })

-- file explorer
require("oil").setup()
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File explorer" })

-- fuzzy finder
local telescope = require("telescope")
telescope.load_extension("ui-select")
telescope.setup({
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
	defaults = {
		mappings = {
			i = { ["<c-t>"] = require("trouble.sources.telescope").open },
			n = { ["<c-t>"] = require("trouble.sources.telescope").open },
		},
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
})

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

require("trouble").setup({
	opts = {
		modes = {
			diagnostics = {
				auto_open = true,
				auto_close = true,
			},
		},
	},
})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xX",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
})
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "[G]it [F]iles" })

local symbols = require("trouble").statusline({
	mode = "lsp_document_symbols",
	groups = {},
	title = false,
	filter = { range = true },
	format = "{kind_icon}{symbol.name:Normal}",
	hl_group = "lualine_c_normal",
})
require("lualine").setup({
	sections = {
		lualine_c = {
			"filename",
			{ symbols.get, cond = symbols.has },
		},
	},
})

-- which-key
require("which-key").setup({
	delay = 0,
	icons = {
		mappings = true,
	},
	spec = {
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>r", group = "[R]ename" },
	},
})

-- treesitter
require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})
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

-- colors!
require("rose-pine").setup({
	styles = {
		bold = true,
		italic = false,
		transparency = true,
	},
})
vim.cmd("colorscheme rose-pine")
