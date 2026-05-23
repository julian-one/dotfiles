require("ibl").setup({
	indent = {
		char = "│",
	},
	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
	},
	exclude = {
		filetypes = {
			"help",
			"oil",
			"undotree",
			"trouble",
			"lazy",
			"mason",
			"markdown",
		},
	},
})
