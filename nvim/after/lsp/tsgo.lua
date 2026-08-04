return {
  cmd = { 'tsc', '--lsp', '--stdio' },

  init_options = {
    preferences = {
      quotePreference = 'single',

      importModuleSpecifierPreference = 'non-relative',

      importModuleSpecifierEnding = 'minimal',
    },
  },
}
