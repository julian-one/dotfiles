require("nvim-treesitter").setup()

-- Register the custom tree-sitter-godoc parser (used by godoc.nvim for syntax
-- highlighting of `go doc` output). Must happen before install() below.
require("nvim-treesitter.parsers").godoc = {
	install_info = {
		url = "https://github.com/fredrikaverpil/tree-sitter-godoc",
		files = { "src/parser.c" },
		version = "*",
	},
	filetype = "godoc",
}
vim.treesitter.language.register("godoc", "godoc")

require("nvim-treesitter").install({
	"bash",
	"css",
	"diff",
	"dockerfile",
	"gitignore",
	"go",
	"godoc",
	"gomod",
	"gosum",
	"gowork",
	"html",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"query",
	"regex",
	"sql",
	"svelte",
	"templ",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start(ev.buf, lang)
		end
	end,
})

-- nvim-treesitter-textobjects (main branch): select + move around functions/classes
require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
		selection_modes = {
			["@function.outer"] = "V",
			["@class.outer"] = "V",
		},
		include_surrounding_whitespace = false,
	},
	move = {
		set_jumps = true,
	},
})

local ts_select = require("nvim-treesitter-textobjects.select").select_textobject
local ts_move = require("nvim-treesitter-textobjects.move")

local function map_select(lhs, query, desc)
	vim.keymap.set({ "x", "o" }, lhs, function()
		ts_select(query, "textobjects")
	end, { desc = desc })
end
map_select("af", "@function.outer", "outer function")
map_select("if", "@function.inner", "inner function")
map_select("ac", "@class.outer", "outer class")
map_select("ic", "@class.inner", "inner class")
map_select("aa", "@parameter.outer", "outer parameter")
map_select("ia", "@parameter.inner", "inner parameter")

local function map_move(lhs, fn, query, desc)
	vim.keymap.set({ "n", "x", "o" }, lhs, function()
		fn(query, "textobjects")
	end, { desc = desc })
end
map_move("]f", ts_move.goto_next_start, "@function.outer", "Next function start")
map_move("[f", ts_move.goto_previous_start, "@function.outer", "Prev function start")
map_move("]F", ts_move.goto_next_end, "@function.outer", "Next function end")
map_move("[F", ts_move.goto_previous_end, "@function.outer", "Prev function end")
map_move("]c", ts_move.goto_next_start, "@class.outer", "Next class start")
map_move("[c", ts_move.goto_previous_start, "@class.outer", "Prev class start")

-- nvim-treesitter-context: sticky function/class header at top of window
require("treesitter-context").setup({
	max_lines = 3,
	trim_scope = "outer",
	min_window_height = 20,
})
vim.keymap.set("n", "[x", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { desc = "Jump to context (parent scope)" })
