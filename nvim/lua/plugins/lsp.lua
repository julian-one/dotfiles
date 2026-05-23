-- Mason: mason.setup() must run first (registers binary paths on PATH).
-- mason-lspconfig and mason-tool-installer follow. With vim.lsp.enable()
-- below, mason-lspconfig's handler dispatch is unused — it's only loaded
-- so its lspconfig/mason name mappings are registered.
require("mason").setup({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "󰄳",
			package_pending = "󰄮",
			package_uninstalled = "󰚌",
		},
	},
})
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
	ensure_installed = {
		-- LSP servers
		"lua-language-server",
		"typescript-language-server",
		"gopls",
		"svelte-language-server",
		"tailwindcss-language-server",
		"emmet-ls",
		"html-lsp",
		"css-lsp",
		"templ",
		"json-lsp",
		"yaml-language-server",
		"dockerfile-language-server",
		"bash-language-server",
		-- Formatters
		"stylua",
		"prettierd",
		"prettier",
		"goimports",
		"gofumpt",
		"golines",
		"sql-formatter",
		-- Linters
		"eslint_d",
		"golangci-lint",
		"codespell",
		-- Debug adapters
		"delve",
		-- Go tooling (go.nvim)
		"gomodifytags",
		"impl",
		"gotests",
		"iferr",
	},
})

-- Explicitly enable LSP servers. Configs are merged from nvim/lsp/<name>.lua
-- (Neovim 0.11+ native). Keep this list in sync with mason-tool-installer above.
vim.lsp.enable({
	"lua_ls",
	"ts_ls",
	"gopls",
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
})

-- Shared augroup referenced by both LspDetach and LspAttach handlers
local lsp_highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
local lsp_detach_augroup = vim.api.nvim_create_augroup("lsp-detach", { clear = true })

vim.api.nvim_create_autocmd("LspDetach", {
	group = lsp_detach_augroup,
	callback = function(event)
		vim.lsp.buf.clear_references()
		vim.api.nvim_clear_autocmds({ group = lsp_highlight_augroup, buffer = event.buf })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
		map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		map("gy", vim.lsp.buf.type_definition, "[G]oto T[y]pe Definition")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
		map("gO", vim.lsp.buf.document_symbol, "[G]oto Document Symbols")
		map("gW", vim.lsp.buf.workspace_symbol, "[G]oto Workspace Symbols")

		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = lsp_highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = lsp_highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})
		end

		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			-- Initialise once per buffer so a later LSP attach (e.g. ESLint joining
			-- TS) cannot clobber a user toggle made via <leader>th.
			if not vim.b[event.buf].inlay_hints_initialized then
				vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
				vim.b[event.buf].inlay_hints_initialized = true
			end
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})
