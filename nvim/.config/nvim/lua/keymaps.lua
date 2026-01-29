-- general
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- fzf-lua
local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sd", fzf.diagnostics_workspace, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>ss", fzf.builtin, { desc = "[S]earch [S]elect Fzf" })
vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", fzf.blines, { desc = "[/] Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader>s/", fzf.lines, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>sn", function()
	fzf.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

-- quicker
vim.keymap.set("n", "<leader>q", function()
	require("quicker").toggle()
end, { desc = "Toggle quickfix" })

-- oil
vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "File explorer" })

-- undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Undo tree" })
