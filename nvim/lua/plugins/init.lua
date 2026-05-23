vim.pack.add({
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/folke/noice.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/Saghen/blink.lib" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/onsails/lspkind.nvim" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/leoluz/nvim-dap-go" },
	{ src = "https://github.com/nvim-neotest/neotest" },
	{ src = "https://github.com/fredrikaverpil/neotest-golang" },
	{ src = "https://github.com/haydenmeade/neotest-jest" },
	{ src = "https://github.com/ray-x/guihua.lua" },
	{ src = "https://github.com/ray-x/go.nvim" },
	{ src = "https://github.com/fredrikaverpil/godoc.nvim" },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/NvChad/nvim-colorizer.lua" },
	{ src = "https://github.com/mofiqul/vscode.nvim" },
})

require("plugins.icons") -- devicons first; used by completion and telescope
require("plugins.noice")
require("plugins.treesitter") -- treesitter core + textobjects + context
require("plugins.lsp") -- mason order is enforced inside this module
require("plugins.completion")
require("plugins.autopairs") -- after completion: blink handles accept brackets, autopairs handles typing
require("plugins.surround")
require("plugins.formatting")
require("plugins.undotree")
require("plugins.oil")
require("plugins.telescope")
require("plugins.gitsigns") -- requires telescope to be set up for git_files keymap
require("plugins.lualine")
require("plugins.trouble")
require("plugins.indent")
require("plugins.render_markdown")
require("plugins.dap")
require("plugins.neotest")
require("plugins.go") -- after lsp/dap/neotest: go.nvim augments but does not own these
require("plugins.godoc")
require("plugins.diffview")
require("plugins.tmux_navigator")
require("plugins.which_key")
require("plugins.colorscheme") -- last so highlight overrides win
