--- Provide visual feedback on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

--- Restore cursor position from previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.api.nvim_win_set_cursor(0, mark)
			-- Defer centering so it's applied after render
			vim.schedule(function()
				vim.cmd("normal! zz")
			end)
		end
	end,
})

--- Prevent automatically continuing comments on new lines
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

--- Highlight exclusively the currently active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

--- Disable highlight when leaving window
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = "active_cursorline",
	callback = function()
		vim.opt_local.cursorline = false
	end,
})

--- Bootstrap LSP keymaps and buffer-local features on attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", vim.lsp.buf.definition, "[G]oto [D]definition")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
		map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		map("gy", vim.lsp.buf.type_definition, "[G]oto T[y]pe Definition")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gO", vim.lsp.buf.document_symbol, "[G]oto Document Symbols")
		map("gW", vim.lsp.buf.workspace_symbol, "[G]oto Workspace Symbols")

		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then -- enable dynamic under-cursor referencing
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client.server_capabilities.foldingRangeProvider then -- enable LSP-powered folding
			vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})

--- Pre-configure unlisted `tree-sitter-godoc` parser from custom repository
vim.api.nvim_create_autocmd("User", {
	group = vim.api.nvim_create_augroup("ts_godoc", { clear = true }),
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").godoc = {
			tier = 0,
			install_info = {
				url = "https://github.com/fredrikaverpil/tree-sitter-godoc",
				revision = "main",
			},
		}
	end,
})

--- Bootstrap native `vim.treesitter` highlighter for actively installed parsers
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("ts_language_start", { clear = true }),
	callback = function(args)
		if
			vim.list_contains(require("nvim-treesitter").get_installed(), vim.treesitter.language.get_lang(args.match))
		then
			vim.treesitter.start(args.buf)
		end
	end,
})
