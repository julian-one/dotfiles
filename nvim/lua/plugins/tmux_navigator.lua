-- Seamless cursor movement between vim splits and tmux panes via <C-h/j/k/l>.
-- The matching tmux-side bindings live in tmux/tmux.conf.
-- Default mappings are disabled so we can attach descriptions for which-key.
vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set(
	"n",
	"<C-h>",
	"<cmd>TmuxNavigateLeft<cr>",
	{ desc = "Move to left split/pane", silent = true }
)
vim.keymap.set(
	"n",
	"<C-j>",
	"<cmd>TmuxNavigateDown<cr>",
	{ desc = "Move to lower split/pane", silent = true }
)
vim.keymap.set(
	"n",
	"<C-k>",
	"<cmd>TmuxNavigateUp<cr>",
	{ desc = "Move to upper split/pane", silent = true }
)
vim.keymap.set(
	"n",
	"<C-l>",
	"<cmd>TmuxNavigateRight<cr>",
	{ desc = "Move to right split/pane", silent = true }
)
vim.keymap.set(
	"n",
	"<C-\\>",
	"<cmd>TmuxNavigatePrevious<cr>",
	{ desc = "Move to previous split/pane", silent = true }
)

-- Mirror the navigation keys in terminal mode so the floating terminal and
-- any :terminal buffer can hop windows without first hitting <C-\><C-n>.
local term_nav = {
	["<C-h>"] = "TmuxNavigateLeft",
	["<C-j>"] = "TmuxNavigateDown",
	["<C-k>"] = "TmuxNavigateUp",
	["<C-l>"] = "TmuxNavigateRight",
	["<C-\\>"] = "TmuxNavigatePrevious",
}
for lhs, cmd in pairs(term_nav) do
	vim.keymap.set("t", lhs, [[<C-\><C-n><cmd>]] .. cmd .. "<cr>", {
		desc = "Move to " .. cmd:gsub("TmuxNavigate", "") .. " split/pane (from term)",
		silent = true,
	})
end
