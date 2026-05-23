require("lualine").setup({
	options = {
		theme = "auto",
		section_separators = "",
		component_separators = "|",
		globalstatus = true,
		disabled_filetypes = {
			statusline = { "oil", "undotree", "diff", "trouble", "Trouble" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = {
			{
				function()
					local names = vim
						.iter(vim.lsp.get_clients({ bufnr = 0 }))
						:map(function(c)
							return c.name
						end)
						:totable()
					if #names == 0 then
						return ""
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
