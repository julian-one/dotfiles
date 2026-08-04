vim.pack.add {
  { src = 'https://github.com/projekt0n/github-nvim-theme' },
}

require('github-theme').setup {
  options = {
    transparent = true,
  },
  groups = {
    all = {
      CursorLine = { bg = 'palette.neutral.subtle' },
      LineNr = { fg = 'palette.fg.subtle' },
      FoldColumn = { fg = 'palette.accent.fg', bg = 'NONE' },
      Folded = { fg = 'palette.fg.muted', bg = 'palette.accent.subtle' },
      SignColumn = { bg = 'NONE' },
      WinSeparator = { fg = 'palette.border.muted' },
      ColorColumn = { bg = 'palette.border.muted' },
      FloatTitle = { fg = 'palette.accent.fg', style = 'bold' },
      Pmenu = { fg = 'palette.fg.default', bg = 'NONE' },
      PmenuBorder = { link = 'FloatBorder' },
      LspInlayHint = { fg = 'palette.fg.muted', bg = 'NONE' },

      Search = { bg = 'palette.accent.subtle' },
      HlSearchLens = { fg = 'palette.fg.subtle' },
      HlSearchLensNear = { fg = 'palette.orange', style = 'bold' },

      BlinkCmpMenu = { link = 'NormalFloat' },
      BlinkCmpMenuBorder = { link = 'FloatBorder' },
      BlinkCmpDocBorder = { link = 'FloatBorder' },
      BlinkCmpSignatureHelpBorder = { link = 'FloatBorder' },
      BlinkCmpKind = { link = 'Comment' },

      TelescopeBorder = { link = 'FloatBorder' },
      TelescopeTitle = { link = 'FloatTitle' },
      TelescopeMatching = { fg = 'palette.accent.fg', style = 'bold' },

      WhichKeyNormal = { link = 'NormalFloat' },
      WhichKeyBorder = { link = 'FloatBorder' },
      WhichKeyTitle = { link = 'FloatTitle' },

      MasonNormal = { link = 'NormalFloat' },

      RainbowDelimiterBlue = { fg = 'syntax.const' },
      RainbowDelimiterOrange = { fg = 'syntax.type' },
      RainbowDelimiterViolet = { fg = 'syntax.func' },
      RainbowDelimiterGreen = { fg = 'syntax.tag' },
      RainbowDelimiterYellow = { fg = 'palette.yellow.bright' },
      RainbowDelimiterPink = { fg = 'palette.pink.bright' },
    },
  },
}
vim.cmd.colorscheme 'github_dark_dimmed'
