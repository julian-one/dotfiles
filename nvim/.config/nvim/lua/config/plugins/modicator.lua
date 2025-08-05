return {
	{
		"mawkler/modicator.nvim",
		dependencies = "catppuccin/nvim",
		opts = {
			highlights = {
				defaults = {
					bold = true,
				},
			},
			integration = {
				lualine = {
					enabled = true,
					mode_section = nil,
					highlight = "bg",
				},
			},
		},
		config = function(_, opts)
			local modicator = require("modicator")
			local colors = require("catppuccin.palettes").get_palette("latte")
			
			modicator.setup(vim.tbl_deep_extend("force", opts, {
				highlights = {
					defaults = {
						bold = true,
					},
					NormalMode = { fg = colors.blue },
					InsertMode = { fg = colors.green },
					VisualMode = { fg = colors.mauve },
					CommandMode = { fg = colors.peach },
					ReplaceMode = { fg = colors.red },
					SelectMode = { fg = colors.flamingo },
					TerminalMode = { fg = colors.teal },
					TerminalNormalMode = { fg = colors.blue },
				},
			}))
		end,
	},
}
