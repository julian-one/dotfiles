require("which-key").setup({
	delay = 0,
	icons = {
		mappings = true,
	},
	spec = {
		{ "<leader>b", group = "[B]uffer" },
		{ "<leader>c", group = "[C]ode" },
		{ "<leader>cf", group = "Go [F]ill" },
		{ "<leader>ci", group = "Go [I]nsert" },
		{ "<leader>ct", group = "Go [T]ags" },
		{ "<leader>e", group = "[E]xplorer" },
		{ "<leader>g", group = "[G]it" },
		{ "<leader>h", group = "[H]unk" },
		{ "<leader>r", group = "[R]ename" },
		{ "<leader>s", group = "[S]earch" },
		{ "<leader>t", group = "[T]oggle" },
		{ "<leader>u", group = "[U]ndo" },
		{ "<leader>w", group = "[W]indow" },
		{ "<leader>x", group = "Trouble" },
	},
})
