vim.pack.add {
  { src = 'https://github.com/stevearc/conform.nvim' },
}

local prettier = { 'prettierd', 'prettier', stop_after_first = true }

require('conform').setup {
  formatters_by_ft = {
    go = { 'goimports', 'gofumpt', 'golines' },
    lua = { 'stylua' },
    sql = { 'sql_formatter' },
    javascript = prettier,
    typescript = prettier,
    svelte = prettier,
    ['*'] = { 'codespell' },
    ['_'] = { 'trim_whitespace' },
  },
  format_on_save = {
    lsp_format = 'fallback',
    timeout_ms = 5000,
  },
  formatters = {
    sql_formatter = {
      prepend_args = {
        '--language',
        'postgresql',
        '--config',
        vim.json.encode {
          keywordCase = 'upper',
          functionCase = 'lower',
          dataTypeCase = 'lower',
          identifierCase = 'preserve',
          tabWidth = 2,
        },
      },
    },
  },
}
