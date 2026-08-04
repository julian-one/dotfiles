return {
  cmd = function(dispatchers, config)
    local bin = vim.fs.joinpath(config.root_dir, 'node_modules', '.bin', 'svelteserver')

    return vim.lsp.rpc.start({ bin, '--stdio' }, dispatchers)
  end,
}
