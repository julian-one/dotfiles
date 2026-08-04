return {
  settings = {
    gopls = {
      gofumpt = true,
      staticcheck = true,
      analyses = { ST1000 = false, unusedparams = true },
      buildFlags = { "-tags=integration" },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
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
