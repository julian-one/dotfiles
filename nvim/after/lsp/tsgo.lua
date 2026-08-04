-- brew's typescript ships tsgo inside `tsc`; the formula links no tsgo binary.
return {
  cmd = { "tsc", "--lsp", "--stdio" },
  init_options = {
    preferences = {
      quotePreference = "single",
      importModuleSpecifierPreference = "non-relative",
      importModuleSpecifierEnding = "minimal",
    },
  },
}
