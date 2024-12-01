return {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gdiffsplit', 'Gwrite', 'Gread', 'Gcommit', 'Gpush', 'Gpull', 'Gblame' },
    keys = {
      { '<leader>gs', '<cmd>Git<CR>', desc = 'Git status' },
      { '<leader>gd', '<cmd>Gdiffsplit<CR>', desc = 'Git diff split' },
      { '<leader>gc', '<cmd>Gcommit<CR>', desc = 'Git commit' },
      { '<leader>gp', '<cmd>Gpush<CR>', desc = 'Git push' },
      { '<leader>gP', '<cmd>Gpull<CR>', desc = 'Git pull' },
      { '<leader>gb', '<cmd>Gblame<CR>', desc = 'Git blame' },
    },
  },
}
