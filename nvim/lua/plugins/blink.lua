vim.pack.add {
  { src = 'https://github.com/Saghen/blink.cmp', version = 'v1.10.2' },
  { src = 'https://github.com/onsails/lspkind.nvim' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
  { src = 'https://github.com/mikavilpas/blink-ripgrep.nvim', version = vim.version.range '*' },
}

require('luasnip.loaders.from_vscode').lazy_load()

local function path_icon(ctx)
  if ctx.source_name == 'Path' then
    return require('nvim-web-devicons').get_icon(ctx.label)
  end
end

require('blink.cmp').setup {
  snippets = { preset = 'luasnip' },
  appearance = {
    kind_icons = require('lspkind').symbol_map,
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { scrollbar = false },
    },
    menu = {
      scrollbar = false,
      draw = {
        treesitter = { 'lsp' },
        gap = 2,
        columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
        components = {
          kind_icon = {
            text = function(ctx) return (path_icon(ctx) or ctx.kind_icon) .. ctx.icon_gap end,
            highlight = function(ctx)
              local icon, hl = path_icon(ctx)
              return icon and hl or ctx.kind_hl
            end,
          },
        },
      },
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep' },
    providers = {
      ripgrep = {
        module = 'blink-ripgrep',
        name = 'Ripgrep',
        opts = {
          backend = { use = 'gitgrep-or-ripgrep' },
        },
      },
    },
  },
  signature = { enabled = true },
}
