-- Options
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.number = true -- absolute line number in the gutter
vim.o.relativenumber = true -- other lines count from the cursor, for {count}j/k
vim.o.cursorline = true -- highlight the line the cursor is on
vim.o.wrap = false -- long lines run off-screen instead of onto the next row
vim.o.scrolloff = 10 -- keep 10 lines above and below the cursor (999 pins it to the middle)
vim.o.sidescrolloff = 10 -- the same in columns; only applies while 'wrap' is off

vim.o.tabstop = 2 -- display width of a literal <Tab>
vim.o.shiftwidth = 2 -- indent width for >>, << and auto-indent
vim.o.expandtab = true -- <Tab> inserts spaces, never a literal tab

vim.o.hlsearch = false -- only the match under the cursor lights up, and only while typing
vim.o.ignorecase = true -- searches ignore case...
vim.o.smartcase = true -- ...unless the typed pattern has an uppercase letter
vim.o.inccommand = "split" -- live :s preview in a split ("nosplit" = buffer only, "" = off)
vim.opt.wildoptions:append("fuzzy") -- cmdline completion matches fuzzily, ranked by best match

vim.o.completeopt = "menu,menuone,popup,noselect"
vim.o.winborder = "rounded" -- float border style ("single"|"double"|"bold"|"solid"|"shadow"|"none")
vim.o.signcolumn = "yes" -- always show the sign gutter so text never shifts ("auto"|"no"|"number")
vim.o.colorcolumn = "100" -- highlight column 100; accepts a list, or "+1" off 'textwidth'
vim.o.laststatus = 3 -- one statusline for all windows (0 = none, 1 = when split, 2 = per window)

vim.o.swapfile = false -- no .swp files, so no recovery prompts
vim.o.undofile = true -- undo history persists across sessions, in stdpath("state")
vim.o.timeoutlen = 500 -- ms to wait for the rest of a mapping, e.g. <leader>sf
vim.o.ttimeoutlen = 0 -- ms to wait for the rest of a key code, so <Esc> is instant
vim.o.updatetime = 200 -- ms of idle before CursorHold and swap-write; speeds up gitsigns blame
vim.o.mouse = "" -- no mouse!

vim.o.foldlevel = 99 -- folds deeper than this close, so 99 opens every buffer unfolded
vim.o.foldmethod = "expr" -- fold levels come from 'foldexpr' ("manual"|"indent"|"marker"|"syntax")
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- builtin treesitter folds; returns 0 without a parser
vim.o.foldtext = "" -- closed folds show the first line with its normal highlighting

-- Keymaps
vim.keymap.set("n", "U", "<c-r>", { silent = true })
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set(
  "n",
  "<leader>rs",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Substitute word under cursor" }
)
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("x", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
local function navigate(dir, pane)
  return function()
    local win = vim.api.nvim_get_current_win()
    vim.cmd.wincmd(dir)
    if win == vim.api.nvim_get_current_win() and vim.env.TMUX then
      vim.system({ "tmux", "select-pane", pane })
    end
  end
end
vim.keymap.set("n", "<C-h>", navigate("h", "-L"), { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", navigate("j", "-D"), { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", navigate("k", "-U"), { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", navigate("l", "-R"), { desc = "Move to right split" })

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>rr", "<cmd>wincmd r<cr>", { desc = "Rotate splits" })

local session_file = vim.fn.stdpath("state") .. "/Session.vim"
vim.keymap.set("n", "<leader>re", function()
  vim.cmd("mks! " .. vim.fn.fnameescape(session_file))
  vim.cmd("restart source " .. vim.fn.fnameescape(session_file))
end, { desc = "Restart nvim and restore session" })

local function copy_ref(opts)
  local path = vim.fn.expand("%:.")
  local ref = path
  if opts.visual then
    -- '< and '> are only set after leaving visual mode, so read the live selection
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    ref = path .. ":" .. start_line .. ":" .. end_line
  end
  local note = vim.fn.input("Prompt (optional): ")
  if note ~= "" then
    ref = ref .. " " .. note
  end
  vim.fn.setreg("+", ref)
  vim.notify("Copied: " .. ref)
end
vim.keymap.set("n", "<leader>cp", function()
  copy_ref({})
end, { desc = "Copy file path" })
vim.keymap.set("x", "<leader>cp", function()
  copy_ref({ visual = true })
end, { desc = "Copy file path with line range" })

vim.keymap.set("n", "<leader>i", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  vim.notify(vim.lsp.inlay_hint.is_enabled() and "Inlay hints enabled" or "Inlay hints disabled")
end, { desc = "Toggle inlay hints" })

-- Diagnostics
vim.diagnostic.config({ severity_sort = true, virtual_text = true })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, { desc = "Diagnostics to quickfix" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostic float" })

-- Plugins
vim.pack.add({
  { src = "https://github.com/mofiqul/vscode.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" }, -- data only: default configs for vim.lsp.enable()
  { src = "https://github.com/folke/lazydev.nvim" }, -- lua_ls: nvim runtime types, loaded per require()
  { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- file icons for telescope and oil
  { src = "https://github.com/nvim-lua/plenary.nvim" }, -- telescope dependency
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/folke/todo-comments.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/Saghen/blink.lib" },
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/OXY2DEV/markview.nvim" },
  { src = "https://github.com/OXY2DEV/helpview.nvim" },
})

-- Color
require("vscode").setup({
  transparent = true,
  italic_comments = true,
  italic_inlayhints = true,
  underline_links = true,
})
vim.cmd.colorscheme("vscode")

-- Treesitter
require("nvim-treesitter").install({
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "go",
  "gomod",
  "gosum",
  "gowork",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "sql",
  "svelte",
  "templ",
  "typescript",
  "yaml",
})

-- Updated queries require matching parsers.
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("treesitter_pack_update", { clear = true }),
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
      require("nvim-treesitter").update()
    end
  end,
})

-- The main branch doesn't auto-start highlighting.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
    if lang and vim.treesitter.language.add(lang) then
      vim.treesitter.start(ev.buf, lang)
    end
  end,
})

-- Conform
local prettier = { "prettierd", "prettier", stop_after_first = true }
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofumpt", "golines" },
    javascript = prettier,
    typescript = prettier,
    svelte = prettier,
    html = prettier,
    css = prettier,
    json = prettier,
    jsonc = prettier,
    yaml = prettier,
    markdown = prettier,
    sql = { "sql_formatter" },
  },
  default_format_opts = { lsp_format = "fallback" },
  format_on_save = { timeout_ms = 2000 },
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.keymap.set({ "n", "x" }, "<leader>f", function()
  require("conform").format({ async = true })
end, { desc = "Format buffer" })

-- Blink
require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
  snippets = { preset = "luasnip" },
  keymap = { preset = "default" },
  completion = {
    menu = {
      auto_show = true,
      draw = {
        treesitter = { "lsp" },
        columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
      },
    },
    documentation = { auto_show = true },
  },
  signature = { enabled = true },
  -- Lua matcher: skips the Rust build and blink's prebuilt-binary download.
  fuzzy = { implementation = "lua" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      lsp = { score_offset = 90 },
    },
  },
})

-- LSP
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

-- Overrides live in after/lsp/ so they win over nvim-lspconfig's defaults (:h lsp-config-merge).
vim.lsp.enable({
  "bashls",
  "clangd",
  "dockerls",
  "gopls",
  "lua_ls",
  "svelte",
  "tailwindcss",
  "templ",
  "tsgo",
  "yamlls",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- nowait: `gr` fires instantly instead of waiting out the longer default gr* maps.
    local map = function(keys, func, desc, mode)
      vim.keymap.set(
        mode or "n",
        keys,
        func,
        { buffer = ev.buf, nowait = true, desc = "LSP: " .. desc }
      )
    end
    map("gd", vim.lsp.buf.definition, "Goto definition")
    map("gD", vim.lsp.buf.declaration, "Goto declaration")
    map("gr", vim.lsp.buf.references, "Goto references")
    map("gi", vim.lsp.buf.implementation, "Goto implementation")
    map("gy", vim.lsp.buf.type_definition, "Goto type definition")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
    map("gW", vim.lsp.buf.workspace_symbol, "Workspace symbols")

    if client.name == "clangd" then
      map("gh", "<cmd>LspClangdSwitchSourceHeader<cr>", "Switch source/header")
    end

    if client:supports_method("textDocument/codeLens") then
      map("<leader>cl", vim.lsp.codelens.run, "Run codelens")
      vim.lsp.codelens.enable(true, { bufnr = ev.buf })
    end
  end,
})

-- Oil
require("oil").setup({ view_options = { show_hidden = true } })
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

-- Telescope
require("telescope").setup({})
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search files" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by grep" })
vim.keymap.set({ "n", "x" }, "<leader>sw", builtin.grep_string, { desc = "Search current word" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
vim.keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "Search man pages" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "Search commands" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Resume last search" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Search recent files" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search telescope pickers" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Git files" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>s/", function()
  builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
end, { desc = "Search in open files" })
vim.keymap.set("n", "<leader>sn", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Search neovim config" })

-- Gitsigns
require("gitsigns").setup({
  current_line_blame = true,
})
vim.keymap.set("n", "<leader>gm", "<cmd>Gitsigns diffthis main<cr>", { desc = "Diff against main" })

-- Fidget
require("fidget").setup({})

-- Trouble
require("trouble").setup()
require("todo-comments").setup()
vim.keymap.set(
  "n",
  "<leader>tr",
  "<cmd>Trouble diagnostics toggle<cr>",
  { desc = "Trouble diagnostics" }
)
vim.keymap.set("n", "<leader>td", "<cmd>Trouble todo toggle<cr>", { desc = "Trouble todos" })

-- Markview & Helpview
require("markview").setup()
require("helpview").setup()

-- Autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  desc = "highlight selection on yank",
  callback = function()
    vim.hl.on_yank({ timeout = 200, visual = true })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
  desc = "restore cursor to last position in file",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
      vim.api.nvim_win_set_cursor(0, mark)
      -- defer centering so it applies after the first render
      vim.schedule(function()
        vim.cmd("normal! zz")
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("help_vsplit", { clear = true }),
  pattern = "help",
  command = "wincmd L",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", { clear = true }),
  desc = "no comment continuation on new lines",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

local cursorline_group = vim.api.nvim_create_augroup("active_cursorline", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
  group = cursorline_group,
  callback = function()
    vim.wo.cursorline = true
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = cursorline_group,
  callback = function()
    vim.wo.cursorline = false
  end,
})

vim.api.nvim_create_user_command("PackClean", function()
  local inactive = vim
    .iter(vim.pack.get())
    :filter(function(x)
      return not x.active
    end)
    :map(function(x)
      return x.spec.name
    end)
    :totable()
  if #inactive == 0 then
    vim.notify("No inactive plugins to remove", vim.log.levels.INFO)
    return
  end
  vim.pack.del(inactive)
  vim.notify("Removed: " .. table.concat(inactive, ", "), vim.log.levels.INFO)
end, { desc = "Remove plugins not in vim.pack.add() specs" })
