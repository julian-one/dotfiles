require("options")
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
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
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
		documentation = { auto_show = true },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets" },
	},
})

-- formatting
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofumpt", "golines" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		svelte = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		sql = { "pg_format" },
		["*"] = { "codespell" },
		["_"] = { "trim_whitespace" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = {
		lsp_format = "fallback",
		timeout_ms = 500,
	},
	format_after_save = {
		lsp_format = "fallback",
	},
	log_level = vim.log.levels.ERROR,
	notify_on_error = true,
	notify_no_formatters = true,
})

require("quicker").setup() -- quickfix
require("oil").setup() -- file explorer

-- fuzzy finder
require("telescope").setup({
	defaults = {
		layout_strategy = "bottom_pane",
		layout_config = {
			height = 0.4,
			prompt_position = "bottom",
		},
		border = true,
		hidden = true,
	},
	extensions = {
		fzf = {},
		["ui-select"] = {},
	},
	pickers = {
		live_grep = {
			file_ignore_patterns = { "node_modules", ".git" },
			additional_args = function(_)
				return { "--hidden" }
			end,
		},
		find_files = {
			file_ignore_patterns = { "node_modules", ".git" },
			hidden = true,
		},
	},
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fidget")

require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
})
-- statusline
require("mini.statusline").setup({
	use_icons = true,
	set_vim_settings = false,
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

require("keymaps")
