require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    go = { 'goimports', 'gofumpt', 'golines' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    svelte = { 'prettierd', 'prettier', stop_after_first = true },
    ['*'] = { 'codespell' },
    ['_'] = { 'trim_whitespace' },
  },
  default_format_opts = {
    lsp_format = 'fallback',
  },
  format_on_save = {
    lsp_format = 'fallback',
    timeout_ms = 500,
  },
  format_after_save = {
    lsp_format = 'fallback',
  },
  log_level = vim.log.levels.ERROR,
  notify_on_error = true,
  notify_no_formatters = true,
}

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
