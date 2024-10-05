return {
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup {
        '*', -- Highlight all files, but you can specify filetypes if needed
      }
    end,
  },
}
