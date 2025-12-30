vim.g.mapleader = " " -- leader key
vim.g.maplocalleader = " " -- local leader key
vim.g.have_nerd_font = true -- enable nerd font icons
vim.opt.winborder = "rounded" -- rounded window borders
vim.opt.showmode = true -- show mode in command line
vim.opt.mouse = "" -- disable mouse
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
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
	},
})
