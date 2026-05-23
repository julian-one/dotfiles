--- Render commit time as a coarse human-readable interval (e.g. "3h ago").
local function relative_time(unix_time)
	local diff = os.time() - unix_time
	if diff < 60 then
		return diff .. "s ago"
	elseif diff < 3600 then
		return math.floor(diff / 60) .. "m ago"
	elseif diff < 86400 then
		return math.floor(diff / 3600) .. "h ago"
	elseif diff < 604800 then
		return math.floor(diff / 86400) .. "d ago"
	elseif diff < 2592000 then
		return math.floor(diff / 604800) .. "w ago"
	elseif diff < 31536000 then
		return math.floor(diff / 2592000) .. "mo ago"
	else
		return math.floor(diff / 31536000) .. "y ago"
	end
end

require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_formatter = function(_, blame_info)
		if blame_info.author == "Not Committed Yet" then
			return { { blame_info.author, "GitSignsCurrentLineBlame" } }
		end
		local text = string.format(
			"%s, %s - %s",
			blame_info.author,
			relative_time(tonumber(blame_info["author_time"]) or 0),
			blame_info.summary
		)
		return { { text, "GitSignsCurrentLineBlame" } }
	end,
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "Git: " .. desc })
		end

		map("]h", function()
			gs.nav_hunk("next")
		end, "Next [H]unk")
		map("[h", function()
			gs.nav_hunk("prev")
		end, "Prev [H]unk")
		map("<leader>hs", gs.stage_hunk, "[H]unk [S]tage")
		map("<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "[H]unk [S]tage selection", "v")
		map("<leader>hr", gs.reset_hunk, "[H]unk [R]eset")
		map("<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "[H]unk [R]eset selection", "v")
		map("<leader>hp", gs.preview_hunk, "[H]unk [P]review")
		map("<leader>hb", gs.blame_line, "[H]unk [B]lame line")
	end,
})
vim.keymap.set(
	"n",
	"<leader>gf",
	require("telescope.builtin").git_files,
	{ desc = "[G]it [F]iles" }
)
