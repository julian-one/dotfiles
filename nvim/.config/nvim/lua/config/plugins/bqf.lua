return {
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf", -- load only for quickfix filetype
		opts = {
			auto_enable = true,
			preview = {
				win_height = 15,
				win_vheight = 15,
				delay_syntax = 80,
				border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				show_title = false,
				should_preview_cb = function(bufnr, qf_winid)
					local bufname = vim.api.nvim_buf_get_name(bufnr)
					return not bufname:match("^fugitive://")
				end,
			},
			func_map = {
				open = "<CR>",
				drop = "o",
				split = "s",
				vsplit = "v",
				tabdrop = "t",
				toggle_mode = "z,",
				toggle_preview = "zp",
				preview_scroll_up = "<C-u>",
				preview_scroll_down = "<C-d>",
			},
			filter = {
				fzf = {
					action_for = {
						["ctrl-s"] = "split",
						["ctrl-v"] = "vsplit",
						["ctrl-t"] = "tab drop",
					},
					extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
				},
			},
		},
	},
}
