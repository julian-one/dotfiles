local highlight = vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach', { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    if client:supports_method('textDocument/documentHighlight', ev.buf) then
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = highlight,
        buffer = ev.buf,
        desc = 'highlight other references to the symbol under the cursor',
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        group = highlight,
        buffer = ev.buf,
        desc = 'clear those highlights on cursor move',
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

vim.api.nvim_create_autocmd('LspDetach', {
  group = vim.api.nvim_create_augroup('lsp_detach', { clear = true }),
  desc = 'remove document highlights when a server disconnects',
  callback = function(ev)
    vim.lsp.buf.clear_references()

    vim.api.nvim_clear_autocmds { group = highlight, buffer = ev.buf }
  end,
})

vim.lsp.enable {
  'bashls',
  'clangd',
  'dockerls',
  'gopls',
  'lua_ls',
  'svelte',
  'tailwindcss',
  'templ',
  'tsgo',
  'yamlls',
}
