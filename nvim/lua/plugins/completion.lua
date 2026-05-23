require("lspkind").init({})

require("blink.cmp").setup({
	cmdline = { enabled = true },
	appearance = {
		nerd_font_variant = "mono",
		use_nvim_cmp_as_default = false,
	},
	completion = {
		list = {
			selection = { preselect = true, auto_insert = false },
		},
		menu = {
			border = "rounded",
			draw = {
				treesitter = { "lsp" },
				columns = {
					{ "kind_icon" },
					{ "label", "label_description", gap = 1 },
					{ "kind" },
				},
				components = {
					kind_icon = {
						text = function(ctx)
							if ctx.source_name ~= "Path" then
								return (require("lspkind").symbol_map[ctx.kind] or "") .. ctx.icon_gap
							end
							if ctx.item.data.type == "directory" then
								return "󰉋" .. ctx.icon_gap
							end
							local icon, _ =
								require("nvim-web-devicons").get_icon(ctx.label, nil, { default = true })
							return (icon or ctx.kind_icon) .. ctx.icon_gap
						end,
						highlight = function(ctx)
							if ctx.source_name ~= "Path" then
								return ctx.kind_hl
							end
							if ctx.item.data.type == "directory" then
								return "Directory"
							end
							local _, hl =
								require("nvim-web-devicons").get_icon(ctx.label, nil, { default = true })
							return hl or ctx.kind_hl
						end,
					},
				},
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "rounded" },
		},
		ghost_text = { enabled = false, show_with_menu = true },
		accept = { auto_brackets = { enabled = true } },
	},
	signature = {
		enabled = true,
		window = { border = "rounded" },
	},
	fuzzy = { implementation = "prefer_rust" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			lsp = { fallbacks = { "buffer" } },
			buffer = {
				min_keyword_length = 3,
				max_items = 5,
			},
		},
	},
})
