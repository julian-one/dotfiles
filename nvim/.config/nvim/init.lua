require("config.lazy")

vim.opt.wrap = false

-- Mouse
vim.opt.mouse = ""
vim.keymap.set("", "<ScrollWheelUp>", "<Nop>", { silent = true })
vim.keymap.set("", "<ScrollWheelDown>", "<Nop>", { silent = true })
vim.keymap.set("", "<ScrollWheelLeft>", "<Nop>", { silent = true })
vim.keymap.set("", "<ScrollWheelRight>", "<Nop>", { silent = true })

vim.api.nvim_set_keymap("", "<ScrollWheelUp>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<ScrollWheelDown>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<ScrollWheelLeft>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "<ScrollWheelRight>", "<Nop>", { noremap = true, silent = true })



-- Numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Completions
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.signcolumn = 'yes'


vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
