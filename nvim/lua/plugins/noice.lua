require("notify").setup({
	timeout = 3000,
	max_width = 80,
	stages = "fade",
	render = "compact",
	background_colour = "#000000",
})

require("noice").setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
		format = {
			cmdline = { icon = ">" },
			search_down = { icon = " " },
			search_up = { icon = " " },
			filter = { icon = "$" },
			lua = { icon = "" },
			help = { icon = "?" },
		},
	},
	messages = {
		enabled = true,
		view = "notify",
		view_error = "notify",
		view_warn = "notify",
		view_history = "messages",
		view_search = "virtualtext",
	},
	popupmenu = {
		enabled = false, -- blink.cmp handles cmdline completion
	},
	notify = {
		enabled = true,
		view = "notify",
	},
	lsp = {
		progress = { enabled = true }, -- replaces fidget
		hover = { enabled = true },
		signature = { enabled = false }, -- blink.cmp handles signatures
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
		},
	},
	presets = {
		bottom_search = true,
		long_message_to_split = true,
	},
	routes = {
		{
			filter = { event = "msg_show", kind = "", find = "written" },
			opts = { skip = true },
		},
		{
			-- Neovim core fires `vim.notify_once("watch.watch: ENOENT…")` from
			-- vim/_watch.lua when an LSP server registers a watcher on a path
			-- that doesn't exist (placeholder until the nvim_log API lands).
			-- Harmless info; suppress.
			filter = { event = "notify", find = "^watch%.watch:" },
			opts = { skip = true },
		},
	},
	views = {
		hover = {
			border = { style = "rounded", padding = { 0, 1 } },
			size = { max_height = 30, max_width = 80 },
			win_options = { wrap = true, linebreak = true },
		},
		cmdline_popup = {
			position = { row = "50%", col = "50%" },
			size = { width = 60, min_height = 1 },
		},
		popupmenu = {
			relative = "editor",
			position = { row = 8, col = "50%" },
			size = { width = 60, height = 10 },
			border = { style = "rounded", padding = { 0, 1 } },
		},
	},
})
