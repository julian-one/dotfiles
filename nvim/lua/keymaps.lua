vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- <C-h/j/k/l> split/pane navigation is provided by vim-tmux-navigator
-- (see lua/plugins/tmux_navigator.lua)

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "]q", "<cmd>cnext<cr>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", "<cmd>cprev<cr>zz", { desc = "Prev quickfix" })
vim.keymap.set("n", "]Q", "<cmd>clast<cr>zz", { desc = "Last quickfix" })
vim.keymap.set("n", "[Q", "<cmd>cfirst<cr>zz", { desc = "First quickfix" })

vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "[B]uffer [D]elete" })
vim.keymap.set("n", "<leader>bn", "<cmd>enew<cr>", { desc = "[B]uffer [N]ew" })

vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "[W]indow [V]ertical split" })
vim.keymap.set("n", "<leader>ws", "<cmd>split<cr>", { desc = "[W]indow horizontal [S]plit" })
vim.keymap.set("n", "<leader>wc", "<cmd>close<cr>", { desc = "[W]indow [C]lose" })
vim.keymap.set("n", "<leader>wo", "<cmd>only<cr>", { desc = "[W]indow [O]nly (close others)" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "[W]indow equal sizes" })

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Resize window up" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Resize window down" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Resize window left" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize window right" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("x", "<leader>P", '"_dP', { desc = "[P]aste without clobbering register" })

vim.keymap.set(
	"n",
	"<leader>td",
	"<cmd>NoiceDismiss<cr>",
	{ desc = "[T]oggle [D]ismiss notifications" }
)
