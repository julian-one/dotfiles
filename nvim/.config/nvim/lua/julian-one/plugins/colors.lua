function ColorMyPencils(color)
  color = color or 'vscode' -- default to vscode if no color is specified
  vim.cmd.colorscheme(color)
  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

return {
  { -- Use vscode.nvim colorscheme
    'Mofiqul/vscode.nvim',
    priority = 1000, -- Make sure to load this before all other start plugins.
    config = function()
      require('vscode').setup {
        -- Enable transparent background
        transparent = false,

        -- Enable italic comment
        italic_comments = true,

        -- Disable nvim-tree background color
        disable_nvimtree_bg = true,

        -- Override colors (vscode theme colors)
        color_overrides = {
          vscLineNumber = '#FFFFFF',
        },

        -- Override highlight groups (see :h highlight-args)
        group_overrides = {
          -- this supports the same val table as vim.api.nvim_set_hl
          Cursor = { fg = '#FFFFFF', bg = '#FF0000', bold = true },
        },
      }

      -- Load the color scheme
      ColorMyPencils()
    end,
  },
}
