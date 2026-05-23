require("lualine").setup({
	options = {
		theme = "auto",
		section_separators = "",
		component_separators = "|",
		globalstatus = true,
		disabled_filetypes = {
			statusline = { "oil", "undotree", "diff" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = {
			{
				function()
					local clients = vim.lsp.get_clients({ bufnr = 0 })
					if #clients == 0 then
						return ""
					end
					local names = {}
					for _, c in ipairs(clients) do
						table.insert(names, c.name)
					end
					return "  " .. table.concat(names, ",")
				end,
			},
			"encoding",
			"filetype",
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
