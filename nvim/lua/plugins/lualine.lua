vim.pack.add {
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
}

local fg = string.format('#%06x', vim.api.nvim_get_hl(0, { name = 'Normal' }).fg)
local theme = require 'github-theme.util.lualine'(vim.g.colors_name)
for name, mode in pairs(theme) do
  if name ~= 'inactive' then
    local accent = mode.a.bg
    mode.a = { fg = accent, bg = 'NONE', gui = 'bold' }
    mode.b = { fg = accent, bg = 'NONE' }
    mode.c = { fg = fg, bg = 'NONE' }
  end
end

require('lualine').setup {
  options = {
    theme = theme,
    globalstatus = true,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      {
        'diff',
        source = function()
          local status = vim.b.gitsigns_status_dict
          if status then
            return { added = status.added, modified = status.changed, removed = status.removed }
          end
        end,
        diff_color = {
          added = 'GitSignsAdd',
          modified = 'GitSignsChange',
          removed = 'GitSignsDelete',
        },
      },
    },
    lualine_c = {
      { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
      { 'filename', path = 1, symbols = { modified = '●', readonly = '' } },
    },
    lualine_x = {
      {
        'diagnostics',
        symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
      },
    },
    lualine_y = {},
    lualine_z = { 'location' },
  },
  extensions = { 'oil', 'fugitive', 'quickfix' },
}
