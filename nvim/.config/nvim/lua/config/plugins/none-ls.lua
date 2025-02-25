return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
      sources = {
        null_ls.builtins.completion.spell,
        formatting.sqlformat.with({
          args = { "-", "--identifiers=lower", "--keywords=upper" },
        }),
        formatting.prettier,
        require("none-ls.diagnostics.eslint"),
        require("none-ls.code_actions.eslint"),
      },
    })
  end,
}
