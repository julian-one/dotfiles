-- No brew formula; each project installs svelte-language-server as a devDependency.
return {
  cmd = function(dispatchers, config)
    local bin = vim.fs.joinpath(config.root_dir, "node_modules", ".bin", "svelteserver")
    return vim.lsp.rpc.start({ bin, "--stdio" }, dispatchers)
  end,
}
