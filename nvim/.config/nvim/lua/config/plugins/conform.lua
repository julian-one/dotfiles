return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile", "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
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
		},
	},
}
