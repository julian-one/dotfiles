return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })
      vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "[G]it [C]ommit" })
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "[G]it [P]ush" })
      vim.keymap.set("n", "<leader>gu", ":Git pull<CR>", { desc = "[G]it [U]pdate (pull)" })
      vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { desc = "[G]it [L]og" })
      vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "[G]it [D]iff" })
      vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "[G]it [B]lame" })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require "gitsigns"

        vim.keymap.set("n", "<leader>gh", gitsigns.preview_hunk, { buffer = bufnr, desc = "[G]it [H]unk preview" })
        vim.keymap.set("n", "<leader>gB", gitsigns.blame_line, { buffer = bufnr, desc = "[G]it [B]lame line" })
      end,
    },
  },
}

