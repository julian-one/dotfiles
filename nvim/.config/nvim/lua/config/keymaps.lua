vim.keymap.set('n', '<leader>n', vim.cmd.Ex, { desc = "Open [N]etrw" })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = "[Y]ank to system clipboard" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true, desc = "[Esc]ape terminal mode" })

local terminal_buf = nil
vim.keymap.set("n", "<leader>tt", function()
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    -- Terminal buffer exists; toggle its visibility
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == terminal_buf then
        vim.api.nvim_win_hide(win)
        return
      end
    end
    -- Terminal buffer is hidden; show it in a new split
    vim.cmd.vsplit()
    vim.api.nvim_win_set_buf(0, terminal_buf)
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
  else
    -- Create a new terminal buffer
    vim.cmd.vsplit()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
    terminal_buf = vim.api.nvim_get_current_buf()
  end
end, { desc = "[T]oggle [T]erminal" })

-- no macros plz
vim.keymap.set('n', 'q', '<Nop>', { noremap = true, silent = true })
