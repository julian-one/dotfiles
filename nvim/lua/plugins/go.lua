-- go.nvim: kept in augmentation-only mode.
-- gopls is configured in lsp/gopls.lua, formatting in plugins/formatting.lua,
-- debugging in plugins/dap.lua, tests in plugins/neotest.lua, and text objects
-- in plugins/treesitter.lua. go.nvim must not own any of those.
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
	dap_debug = false,
	dap_debug_keymap = false,
	textobjects = false,
	test_runner = "go",
	verbose_tests = true,
	run_in_floaterm = false,
	trouble = true,
	luasnip = false,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("go_nvim_keymaps", { clear = true }),
	pattern = "go",
	callback = function(ev)
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = "[C]ode Go: " .. desc })
		end
		map("<leader>cie", "<cmd>GoIfErr<cr>", "[I]f [E]rr")
		map("<leader>cfs", "<cmd>GoFillStruct<cr>", "[F]ill [S]truct")
		map("<leader>cfw", "<cmd>GoFillSwitch<cr>", "[F]ill s[W]itch")
		map("<leader>cii", "<cmd>GoImpl<cr>", "[I]mpl [I]nterface")
		map("<leader>cta", "<cmd>GoAddTag<cr>", "[T]ag [A]dd")
		map("<leader>ctr", "<cmd>GoRmTag<cr>", "[T]ag [R]emove")
		map("<leader>ctm", "<cmd>GoModifyTag<cr>", "[T]ag [M]odify")
		map("<leader>cic", "<cmd>GoCmt<cr>", "[I]nsert [C]omment")
		map("<leader>cga", "<cmd>GoAlt<cr>", "[G]o [A]lternate file")
	end,
})
