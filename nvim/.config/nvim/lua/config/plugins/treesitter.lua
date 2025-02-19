return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "bash", "go", "templ", "svelte", "typescript", "javascript", "yaml", "json", "html", "css" },
        sync_install = false,
        auto_install = false,
        ignore_install = { "query" },
        modules = {},
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        },
      })
    end,
  }
}
