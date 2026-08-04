vim.pack.add {
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  { src = 'https://github.com/b0o/SchemaStore.nvim' },
  { src = 'https://github.com/rachartier/tiny-code-action.nvim' },
  { src = 'https://github.com/artemave/workspace-diagnostics.nvim' },
}

require('mason').setup()
require('mason-lspconfig').setup {
  automatic_enable = {
    exclude = { 'stylua' },
  },
}
require('mason-tool-installer').setup {
  ensure_installed = {
    'bashls',
    'biome',
    'clangd',
    'codespell',
    'dockerls',
    'eslint',
    'gofumpt',
    'goimports',
    'golangci_lint_ls',
    'golines',
    'gomodifytags',
    'gopls',
    'gotests',
    'iferr',
    'impl',
    'jsonls',
    'lua_ls',
    'prettier',
    'prettierd',
    'sql-formatter',
    'sqls',
    'stylua',
    'svelte',
    'tailwindcss-language-server',
    'templ',
    'ts_ls',
    'yamlls',
  },
}
require('tiny-code-action').setup {}

vim.lsp.document_color.enable(true, nil, { style = 'virtual' })
vim.lsp.codelens.enable()

local code_action = function() require('tiny-code-action').code_action() end

vim.keymap.set('n', '<leader>ch', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = 'Toggle inlay hints' })
vim.keymap.set({ 'n', 'x' }, '<leader>ca', code_action, { desc = 'Code action' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach', { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    if client:supports_method('workspace/diagnostic', ev.buf) then
      vim.lsp.buf.workspace_diagnostics { client_id = client.id }
    else
      require('workspace-diagnostics').populate_workspace_diagnostics(client, ev.buf)
    end
  end,
})
