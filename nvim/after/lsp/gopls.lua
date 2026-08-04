return {
  settings = {
    gopls = {
      gofumpt = true,

      staticcheck = true,

      analyses = { ST1000 = false, unusedparams = true },

      codelenses = {
        references = true,
        implementations = true,
        gc_details = true,
        run_govulncheck = true,
        test = true,
        generate = true,
      },
    },
  },
}
