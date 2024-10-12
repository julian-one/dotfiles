-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/lazy/trouble.lua
return {
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>tt',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
    },
  },
}
