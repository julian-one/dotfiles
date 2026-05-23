-- go.nvim: kept in augmentation-only mode for struct/tag/interface helpers.
-- gopls is configured in lsp/gopls.lua, formatting in plugins/formatting.lua,
-- text objects in plugins/treesitter.lua. go.nvim must not own any of those.
-- Buffer-local keymaps live in after/ftplugin/go.lua.
require("go").setup({
	disable_defaults = false,
	gofmt = "gofumpt",
	goimports = "gopls",
	fillstruct = "gopls",
	max_line_len = 120,
	tag_options = "json=omitempty",
	icons = false,
	verbose = false,
	lsp_cfg = false,
	lsp_gofumpt = true,
	lsp_keymaps = false,
	lsp_codelens = false,
	lsp_inlay_hints = { enable = false },
	lsp_diag_hdlr = false,
	lsp_document_formatting = false,
	textobjects = false,
	run_in_floaterm = false,
	trouble = true,
	luasnip = false,
})
