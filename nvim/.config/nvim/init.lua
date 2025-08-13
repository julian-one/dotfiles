-- ================================================================================================
-- title : Minimal NeoVim Config (Enhanced)
-- author: Julian (based on Suckless NeoVim Config by Radley E. Sidwell-lewis)
-- ================================================================================================

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Essential plugins only
require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"bash",
					"go",
					"templ",
					"svelte",
					"javascript",
					"typescript",
					"html",
					"css",
					"json",
					"yaml",
					"sql",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"saghen/blink.cmp",
		event = "VimEnter",
		version = "1.*",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "2.*",
				dependencies = { "rafamadriz/friendly-snippets" },
			},
		},
		opts = {
			keymap = { preset = "default" },
			completion = {
				documentation = { auto_show = true, window = { border = "rounded" } },
				menu = { border = "rounded" },
			},
			sources = { default = { "lsp", "path", "snippets" } },
			snippets = { preset = "luasnip" },
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>ma",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Add to harpoon",
			},
			{
				"<leader>mm",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon menu",
			},
			{
				"<leader>m1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Harpoon file 1",
			},
			{
				"<leader>m2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Harpoon file 2",
			},
			{
				"<leader>m3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon file 3",
			},
			{
				"<leader>m4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Harpoon file 4",
			},
		},
		config = function()
			require("harpoon"):setup()
		end,
	},
})

-- Theme & transparency - using default colorscheme with transparency
vim.cmd.colorscheme("default")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Visual settings
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "100"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false

-- Behavior settings
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"

-- Cursor settings
vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Folding settings
vim.opt.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Key mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal mode mappings
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Quick file navigation
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", ":e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

-- Copy Full File-Path
vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy file path to clipboard" })

-- Quickfix list navigation
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })
vim.keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>qp", ":cprevious<CR>", { desc = "Previous quickfix item" })
vim.keymap.set("n", "<leader>qf", ":cfirst<CR>", { desc = "First quickfix item" })
vim.keymap.set("n", "<leader>ql", ":clast<CR>", { desc = "Last quickfix item" })

-- Location list navigation
vim.keymap.set("n", "<leader>lo", ":lopen<CR>", { desc = "Open location list" })
vim.keymap.set("n", "<leader>lc", ":lclose<CR>", { desc = "Close location list" })
vim.keymap.set("n", "<leader>ln", ":lnext<CR>", { desc = "Next location item" })
vim.keymap.set("n", "<leader>lp", ":lprevious<CR>", { desc = "Previous location item" })

-- Register shortcuts
vim.keymap.set("n", "<leader>r", ":registers<CR>", { desc = "Show registers" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- Search and replace helpers
vim.keymap.set("n", "<leader>sr", ":%s/<C-r><C-w>//g<Left><Left>", { desc = "Replace word under cursor" })
vim.keymap.set("v", "<leader>sr", ":s//g<Left><Left>", { desc = "Replace in selection" })
vim.keymap.set(
	"n",
	"<leader>sa",
	":bufdo %s//g | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>",
	{ desc = "Replace in all buffers" }
)

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
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

-- Set filetype-specific settings
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "lua", "python", "sql" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "javascript", "typescript", "json", "html", "css", "yaml", "yml", "svelte" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "go", "templ" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = false -- Go uses tabs
	end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	callback = function()
		local dir = vim.fn.expand("<afile>:p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

-- Command-line completion
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })

-- Better diff options
vim.opt.diffopt:append("linematch:60")

-- Performance improvements
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================

local terminal_state = {
	buf = nil,
	win = nil,
	is_open = false,
}

local function FloatingTerminal()
	if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
		return
	end

	if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
		terminal_state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[terminal_state.buf].bufhidden = "hide"
	end

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	vim.wo[terminal_state.win].winblend = 0
	vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
	vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

	local has_terminal = false
	local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
	for _, line in ipairs(lines) do
		if line ~= "" then
			has_terminal = true
			break
		end
	end

	if not has_terminal then
		vim.fn.termopen(os.getenv("SHELL"))
	end

	terminal_state.is_open = true
	vim.cmd("startinsert")

	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = terminal_state.buf,
		callback = function()
			if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.api.nvim_win_close(terminal_state.win, false)
				terminal_state.is_open = false
			end
		end,
		once = true,
	})
end

vim.keymap.set("n", "<leader>t", FloatingTerminal, { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
	if terminal_state.is_open then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end, { desc = "Close floating terminal" })

-- ============================================================================
-- TABS
-- ============================================================================

vim.opt.showtabline = 1
vim.opt.tabline = ""

vim.cmd([[
  hi TabLineFill guibg=NONE ctermfg=242 ctermbg=NONE
]])

vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>tm", ":tabmove<CR>", { desc = "Move tab" })
vim.keymap.set("n", "<leader>t>", ":tabmove +1<CR>", { desc = "Move tab right" })
vim.keymap.set("n", "<leader>t<", ":tabmove -1<CR>", { desc = "Move tab left" })

local function open_file_in_tab()
	vim.ui.input({ prompt = "File to open in new tab: ", completion = "file" }, function(input)
		if input and input ~= "" then
			vim.cmd("tabnew " .. input)
		end
	end)
end

local function duplicate_tab()
	local current_file = vim.fn.expand("%:p")
	if current_file ~= "" then
		vim.cmd("tabnew " .. current_file)
	else
		vim.cmd("tabnew")
	end
end

local function close_tabs_right()
	local current_tab = vim.fn.tabpagenr()
	local last_tab = vim.fn.tabpagenr("$")
	for i = last_tab, current_tab + 1, -1 do
		vim.cmd(i .. "tabclose")
	end
end

local function close_tabs_left()
	local current_tab = vim.fn.tabpagenr()
	for i = current_tab - 1, 1, -1 do
		vim.cmd("1tabclose")
	end
end

vim.keymap.set("n", "<leader>tO", open_file_in_tab, { desc = "Open file in new tab" })
vim.keymap.set("n", "<leader>td", duplicate_tab, { desc = "Duplicate current tab" })
vim.keymap.set("n", "<leader>tr", close_tabs_right, { desc = "Close tabs to the right" })
vim.keymap.set("n", "<leader>tL", close_tabs_left, { desc = "Close tabs to the left" })

local function smart_close_buffer()
	local buffers_in_tab = #vim.fn.tabpagebuflist()
	if buffers_in_tab > 1 then
		vim.cmd("bdelete")
	else
		vim.cmd("tabclose")
	end
end
vim.keymap.set("n", "<leader>bd", smart_close_buffer, { desc = "Smart close buffer/tab" })

-- ============================================================================
-- STATUSLINE
-- ============================================================================

local function git_branch()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	if branch ~= "" then
		return "  " .. branch .. " "
	end
	return ""
end

local function file_type()
	local ft = vim.bo.filetype
	local icons = {
		lua = "[LUA]",
		python = "[PY]",
		javascript = "[JS]",
		typescript = "[TS]",
		go = "[GO]",
		templ = "[TEMPL]",
		svelte = "[SVELTE]",
		html = "[HTML]",
		css = "[CSS]",
		json = "[JSON]",
		yaml = "[YAML]",
		yml = "[YAML]",
		sql = "[SQL]",
		markdown = "[MD]",
		vim = "[VIM]",
		sh = "[SH]",
	}

	if ft == "" then
		return "  "
	end

	return (icons[ft] or ft)
end

local function lsp_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients > 0 then
		return "  LSP "
	end
	return ""
end

local function file_size()
	local size = vim.fn.getfsize(vim.fn.expand("%"))
	if size < 0 then
		return ""
	end
	if size < 1024 then
		return size .. "B "
	elseif size < 1024 * 1024 then
		return string.format("%.1fK", size / 1024)
	else
		return string.format("%.1fM", size / 1024 / 1024)
	end
end

local function mode_icon()
	local mode = vim.fn.mode()
	local modes = {
		n = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		["\22"] = "V-BLOCK",
		c = "COMMAND",
		s = "SELECT",
		S = "S-LINE",
		["\19"] = "S-BLOCK",
		R = "REPLACE",
		r = "REPLACE",
		["!"] = "SHELL",
		t = "TERMINAL",
	}
	return modes[mode] or "  " .. mode:upper()
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size
_G.lsp_status = lsp_status

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

local function setup_dynamic_statusline()
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
			vim.opt_local.statusline = table.concat({
				"  ",
				"%#StatusLineBold#",
				"%{v:lua.mode_icon()}",
				"%#StatusLine#",
				" │ %f %h%m%r",
				"%{v:lua.git_branch()}",
				" │ ",
				"%{v:lua.file_type()}",
				" | ",
				"%{v:lua.file_size()}",
				" | ",
				"%{v:lua.lsp_status()}",
				"%=",
				"%l:%c  %P ",
			})
		end,
	})
	vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.opt_local.statusline = "  %f %h%m%r │ %{v:lua.file_type()} | %=  %l:%c   %P "
		end,
	})
end

setup_dynamic_statusline()

-- ============================================================================
-- LSP
-- ============================================================================

local function find_root(patterns)
	local path = vim.fn.expand("%:p:h")
	local root = vim.fs.find(patterns, { path = path, upward = true })[1]
	return root and vim.fn.fnamemodify(root, ":h") or path
end

local function setup_shell_lsp()
	vim.lsp.start({
		name = "bashls",
		cmd = { "bash-language-server", "start" },
		filetypes = { "sh", "bash", "zsh" },
		root_dir = find_root({ ".git", "Makefile" }),
		settings = {
			bashIde = {
				globPattern = "*@(.sh|.inc|.bash|.command)",
			},
		},
	})
end

local function setup_python_lsp()
	vim.lsp.start({
		name = "pylsp",
		cmd = { "pylsp" },
		filetypes = { "python" },
		root_dir = find_root({ "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }),
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						enabled = false,
					},
					flake8 = {
						enabled = true,
					},
					black = {
						enabled = true,
					},
				},
			},
		},
	})
end

local function setup_go_lsp()
	vim.lsp.start({
		name = "gopls",
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		root_dir = find_root({ "go.mod", "go.work", ".git" }),
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
			},
		},
	})
end

local function setup_templ_lsp()
	vim.lsp.start({
		name = "templ",
		cmd = { "templ", "lsp" },
		filetypes = { "templ" },
		root_dir = find_root({ "go.mod", "go.work", ".git" }),
		settings = {
			templ = {
				gofmt = true,
				html = {
					format = { enable = true },
				},
			},
		},
	})
end

local function setup_typescript_lsp()
	vim.lsp.start({
		name = "tsserver",
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
		root_dir = find_root({ "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	})
end

local function setup_svelte_lsp()
	vim.lsp.start({
		name = "svelte",
		cmd = { "svelte-language-server", "--stdio" },
		filetypes = { "svelte" },
		root_dir = find_root({ "package.json", "svelte.config.js", "svelte.config.mjs", "svelte.config.cjs", ".git" }),
		settings = {
			svelte = {
				plugin = {
					html = {
						completions = { enable = true, emmet = false },
						hover = { enable = true },
						documentSymbols = { enable = true },
					},
					svelte = {
						completions = { enable = true, emmet = true },
						hover = { enable = true },
						codeActions = { enable = true },
					},
					css = {
						completions = { enable = true, emmet = true },
						hover = { enable = true },
						documentColors = { enable = true },
					},
				},
			},
		},
	})
end

local function setup_html_css_lsp()
	-- HTML LSP
	vim.lsp.start({
		name = "html",
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html" },
		root_dir = find_root({ "package.json", ".git" }),
		settings = {
			html = {
				format = { enable = true },
				hover = { documentation = true, references = true },
			},
		},
	})

	-- CSS LSP
	vim.lsp.start({
		name = "cssls",
		cmd = { "vscode-css-language-server", "--stdio" },
		filetypes = { "css", "scss", "less" },
		root_dir = find_root({ "package.json", ".git" }),
		settings = {
			css = { validate = true },
			scss = { validate = true },
			less = { validate = true },
		},
	})
end

local function setup_json_lsp()
	vim.lsp.start({
		name = "jsonls",
		cmd = { "vscode-json-language-server", "--stdio" },
		filetypes = { "json", "jsonc" },
		root_dir = find_root({ "package.json", ".git" }),
		settings = {
			json = {
				schemas = {
					{
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package.json",
					},
					{
						fileMatch = { "tsconfig.json", "tsconfig.*.json" },
						url = "https://json.schemastore.org/tsconfig.json",
					},
				},
			},
		},
	})
end

local function setup_yaml_lsp()
	vim.lsp.start({
		name = "yamlls",
		cmd = { "yaml-language-server", "--stdio" },
		filetypes = { "yaml", "yml" },
		root_dir = find_root({ ".git" }),
		settings = {
			yaml = {
				format = { enable = true },
				validate = true,
				hover = true,
				completion = true,
				schemas = {
					["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
					["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.yml",
				},
			},
		},
	})
end

local function setup_lua_lsp()
	vim.lsp.start({
		name = "lua_ls",
		cmd = { "lua-language-server" },
		filetypes = { "lua" },
		root_dir = find_root({
			".luarc.json",
			".luarc.jsonc",
			".luacheckrc",
			".stylua.toml",
			"stylua.toml",
			"selene.toml",
			"selene.yml",
			".git",
		}),
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
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
end

local function setup_typos_lsp()
	vim.lsp.start({
		name = "typos_lsp",
		cmd = { "typos-lsp" },
		filetypes = { "*" },
		root_dir = find_root({ ".git", ".typos.toml" }),
		settings = {
			diagnostics = true,
		},
	})
end

local function setup_tailwindcss_lsp()
	vim.lsp.start({
		name = "tailwindcss",
		cmd = { "tailwindcss-language-server", "--stdio" },
		filetypes = {
			"html",
			"css",
			"scss",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
			"templ",
		},
		root_dir = find_root({
			"tailwind.config.js",
			"tailwind.config.ts",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"package.json",
			".git",
		}),
		settings = {
			tailwindCSS = {
				classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning",
				},
				validate = true,
			},
		},
	})
end

local function setup_clangd_lsp()
	vim.lsp.start({
		name = "clangd",
		cmd = {
			"clangd",
			"--background-index",
			"--suggest-missing-includes",
			"--clang-tidy",
			"--header-insertion=iwyu",
		},
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
		root_dir = find_root({
			"compile_commands.json",
			"compile_flags.txt",
			".clangd",
			".git",
			"Makefile",
			"CMakeLists.txt",
		}),
		capabilities = {
			textDocument = {
				completion = {
					editsNearCursor = true,
				},
			},
			offsetEncoding = { "utf-8", "utf-16" },
		},
	})
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "sh,bash,zsh",
	callback = setup_shell_lsp,
	desc = "Start shell LSP",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = setup_python_lsp,
	desc = "Start Python LSP",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = setup_go_lsp,
	desc = "Start Go LSP",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "templ",
	callback = setup_templ_lsp,
	desc = "Start Templ LSP",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "javascript,typescript,javascriptreact,typescriptreact",
	callback = setup_typescript_lsp,
	desc = "Start TypeScript LSP",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "svelte",
	callback = setup_svelte_lsp,
	desc = "Start Svelte LSP",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "html,css,scss,less",
	callback = setup_html_css_lsp,
	desc = "Start HTML/CSS LSP",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "json,jsonc",
	callback = setup_json_lsp,
	desc = "Start JSON LSP",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "yaml,yml",
	callback = setup_yaml_lsp,
	desc = "Start YAML LSP",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = setup_lua_lsp,
	desc = "Start Lua LSP",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "c,cpp,objc,objcpp,cuda",
	callback = setup_clangd_lsp,
	desc = "Start Clangd LSP",
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*",
	callback = function()
		-- Only start typos_lsp for text-like files
		local ft = vim.bo.filetype
		local text_filetypes = {
			"markdown",
			"text",
			"gitcommit",
			"html",
			"css",
			"javascript",
			"typescript",
			"lua",
			"python",
			"go",
			"rust",
			"svelte",
			"templ",
		}

		for _, text_ft in ipairs(text_filetypes) do
			if ft == text_ft then
				setup_typos_lsp()
				break
			end
		end
	end,
	desc = "Start Typos LSP for text files",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "html,css,scss,javascript,javascriptreact,typescript,typescriptreact,svelte,templ",
	callback = setup_tailwindcss_lsp,
	desc = "Start TailwindCSS LSP",
})

local function format_code()
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)
	local filetype = vim.bo[bufnr].filetype

	local cursor_pos = vim.api.nvim_win_get_cursor(0)

	if filetype == "lua" or filename:match("%.lua$") then
		if filename == "" then
			print("Save the file first before formatting Lua")
			return
		end

		local stylua_cmd = "stylua " .. vim.fn.shellescape(filename)
		local stylua_result = vim.fn.system(stylua_cmd)

		if vim.v.shell_error == 0 then
			vim.cmd("checktime")
			vim.api.nvim_win_set_cursor(0, cursor_pos)
			print("Formatted with stylua")
			return
		else
			print("stylua error: " .. stylua_result)
			return
		end
	end

	if filetype == "python" or filename:match("%.py$") then
		if filename == "" then
			print("Save the file first before formatting Python")
			return
		end

		local black_cmd = "black --quiet " .. vim.fn.shellescape(filename)
		local black_result = vim.fn.system(black_cmd)

		if vim.v.shell_error == 0 then
			vim.cmd("checktime")
			vim.api.nvim_win_set_cursor(0, cursor_pos)
			print("Formatted with black")
			return
		else
			print("No Python formatter available (install black)")
			return
		end
	end

	if filetype == "sh" or filetype == "bash" or filename:match("%.sh$") then
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local content = table.concat(lines, "\n")

		local cmd = { "shfmt", "-i", "2", "-ci", "-sr" }
		local result = vim.fn.system(cmd, content)

		if vim.v.shell_error == 0 then
			local formatted_lines = vim.split(result, "\n")
			if formatted_lines[#formatted_lines] == "" then
				table.remove(formatted_lines)
			end
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_lines)
			vim.api.nvim_win_set_cursor(0, cursor_pos)
			print("Shell script formatted with shfmt")
			return
		else
			print("shfmt error: " .. result)
			return
		end
	end

	if filetype == "go" or filename:match("%.go$") then
		if filename == "" then
			print("Save the file first before formatting Go")
			return
		end

		local formatters = {
			{ cmd = "goimports -w", name = "goimports" },
			{ cmd = "gofumpt -w", name = "gofumpt" },
			{ cmd = "golines -w --max-len=100", name = "golines" },
		}

		local formatted_with = {}

		for _, formatter in ipairs(formatters) do
			local cmd = formatter.cmd .. " " .. vim.fn.shellescape(filename)
			local result = vim.fn.system(cmd)

			if vim.v.shell_error == 0 then
				table.insert(formatted_with, formatter.name)
			end
		end

		if #formatted_with > 0 then
			vim.cmd("checktime")
			vim.api.nvim_win_set_cursor(0, cursor_pos)
			print("Formatted with " .. table.concat(formatted_with, ", "))
			return
		else
			local gofmt_cmd = "gofmt -w " .. vim.fn.shellescape(filename)
			local gofmt_result = vim.fn.system(gofmt_cmd)

			if vim.v.shell_error == 0 then
				vim.cmd("checktime")
				vim.api.nvim_win_set_cursor(0, cursor_pos)
				print("Formatted with gofmt (fallback)")
				return
			else
				print("gofmt error: " .. gofmt_result)
				return
			end
		end
	end

	if filetype == "templ" or filename:match("%.templ$") then
		if filename == "" then
			print("Save the file first before formatting Templ")
			return
		end

		local templ_cmd = "templ fmt " .. vim.fn.shellescape(filename)
		local templ_result = vim.fn.system(templ_cmd)

		if vim.v.shell_error == 0 then
			vim.cmd("checktime")
			vim.api.nvim_win_set_cursor(0, cursor_pos)
			print("Formatted with templ fmt")
			return
		else
			print("templ fmt error: " .. templ_result)
			return
		end
	end

	if
		filetype == "javascript"
		or filetype == "typescript"
		or filetype == "javascriptreact"
		or filetype == "typescriptreact"
		or filetype == "json"
		or filetype == "html"
		or filetype == "css"
		or filetype == "scss"
		or filetype == "yaml"
		or filetype == "yml"
		or filetype == "svelte"
		or filetype == "markdown"
	then
		if filename == "" then
			print("Save the file first before formatting")
			return
		end

		-- Configure prettier with specific options
		local prettier_cmd = "prettier --write --tab-width 2 --single-quote --trailing-comma es5 --semi --print-width 100 "
			.. vim.fn.shellescape(filename)
		local prettier_result = vim.fn.system(prettier_cmd)

		if vim.v.shell_error == 0 then
			vim.cmd("checktime")
			vim.api.nvim_win_set_cursor(0, cursor_pos)
			print("Formatted with prettier")
			return
		else
			print("prettier error: " .. prettier_result)
			return
		end
	end

	if filetype == "sql" then
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		local content = table.concat(lines, "\n")

		-- Try sql-formatter if available
		local sqlformat_cmd = { "sql-formatter", "--language", "sql" }
		local result = vim.fn.system(sqlformat_cmd, content)

		if vim.v.shell_error == 0 then
			local formatted_lines = vim.split(result, "\n")
			if formatted_lines[#formatted_lines] == "" then
				table.remove(formatted_lines)
			end
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted_lines)
			vim.api.nvim_win_set_cursor(0, cursor_pos)
			print("SQL formatted with sql-formatter")
			return
		else
			print("sql-formatter not available")
			return
		end
	end

	print("No formatter available for " .. filetype)
end

vim.api.nvim_create_user_command("FormatCode", format_code, {
	desc = "Format current file",
})

vim.keymap.set("n", "<leader>fm", format_code, { desc = "Format file" })

local function lint_code()
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)
	local filetype = vim.bo[bufnr].filetype

	if filetype == "go" then
		if filename == "" then
			print("Save the file first before linting Go")
			return
		end

		-- Try golangci-lint first, fallback to go vet
		local golangci_cmd = "golangci-lint run --out-format=tab "
			.. vim.fn.shellescape(vim.fn.fnamemodify(filename, ":h"))
		local golangci_result = vim.fn.system(golangci_cmd)

		if vim.v.shell_error == 0 then
			print("golangci-lint: No issues found")
			return
		elseif vim.fn.executable("golangci-lint") == 1 then
			-- Parse golangci-lint output
			local lines = vim.split(golangci_result, "\n")
			local qf_list = {}

			for _, line in ipairs(lines) do
				local file, lnum, col, message = line:match("([^:]+):(%d+):(%d+)%s+(.+)")
				if file and lnum and col and message then
					table.insert(qf_list, {
						filename = file,
						lnum = tonumber(lnum),
						col = tonumber(col),
						text = message,
						type = "E",
					})
				end
			end

			if #qf_list > 0 then
				vim.fn.setqflist(qf_list)
				vim.cmd("copen")
				print("golangci-lint issues found - check quickfix list")
			else
				print("golangci-lint output: " .. golangci_result)
			end
			return
		else
			-- Fallback to go vet
			local govet_cmd = "go vet " .. vim.fn.shellescape(filename)
			local govet_result = vim.fn.system(govet_cmd)

			if vim.v.shell_error == 0 then
				print("go vet: No issues found")
			else
				print("go vet issues: " .. govet_result)
			end
			return
		end
	end

	if
		filetype == "javascript"
		or filetype == "typescript"
		or filetype == "javascriptreact"
		or filetype == "typescriptreact"
		or filetype == "svelte"
	then
		if filename == "" then
			print("Save the file first before linting")
			return
		end

		-- Try eslint_d first (faster daemon), fallback to eslint
		local eslint_cmd
		if vim.fn.executable("eslint_d") == 1 then
			eslint_cmd = "eslint_d --format=compact " .. vim.fn.shellescape(filename)
		else
			eslint_cmd = "eslint --format=compact " .. vim.fn.shellescape(filename)
		end

		local eslint_result = vim.fn.system(eslint_cmd)

		if vim.v.shell_error == 0 then
			print("ESLint: No issues found")
		else
			-- Parse eslint compact format output
			local lines = vim.split(eslint_result, "\n")
			local qf_list = {}

			for _, line in ipairs(lines) do
				-- Compact format: file: line x, col y, Error/Warning - message (rule)
				local file, lnum, col, type, message = line:match("([^:]+): line (%d+), col (%d+), (%w+) %- (.*)")
				if file and lnum and col and message then
					table.insert(qf_list, {
						filename = file,
						lnum = tonumber(lnum),
						col = tonumber(col),
						text = message,
						type = type:upper():sub(1, 1),
					})
				end
			end

			if #qf_list > 0 then
				vim.fn.setqflist(qf_list)
				vim.cmd("copen")
				local linter_name = vim.fn.executable("eslint_d") == 1 and "eslint_d" or "eslint"
				print(linter_name .. " issues found - check quickfix list")
			else
				print("ESLint output: " .. eslint_result)
			end
		end
		return
	end

	print("No linter available for " .. filetype)
end

vim.api.nvim_create_user_command("LintCode", lint_code, {
	desc = "Lint current file",
})

vim.keymap.set("n", "<leader>ln", lint_code, { desc = "Lint file" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gs", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		vim.keymap.set("n", "<leader>nd", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>pd", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
	end,
})

vim.diagnostic.config({
	virtual_text = { prefix = "●" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✗",
			[vim.diagnostic.severity.WARN] = "⚠",
			[vim.diagnostic.severity.INFO] = "ℹ",
			[vim.diagnostic.severity.HINT] = "💡",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded" },
})

vim.api.nvim_create_user_command("LspInfo", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		print("No LSP clients attached to current buffer")
	else
		for _, client in ipairs(clients) do
			print("LSP: " .. client.name .. " (ID: " .. client.id .. ")")
		end
	end
end, { desc = "Show LSP client info" })

-- Show all project diagnostics
vim.api.nvim_create_user_command("Diagnostics", function()
	vim.diagnostic.setqflist({ open = true, title = "All Project Diagnostics" })
end, { desc = "Show all project diagnostics" })
