return {
	{
		"mawkler/modicator.nvim",
		dependencies = "folke/tokyonight.nvim", -- Add your colorscheme plugin here
		opts = {
			-- Warn if any required option above is missing. May emit false positives
			-- if some other plugin modifies them, which in that case you can just
			-- ignore. Feel free to remove this line after you've gotten Modicator to
			-- work properly.
			show_warnings = true,
		},
	},
}
