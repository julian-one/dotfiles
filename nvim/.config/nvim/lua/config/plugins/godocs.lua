return {
  {
    "fredrikaverpil/godoc.nvim",
    version = "*",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
          ensure_installed = { "go" },
        },
      },
    },
    ft = { "go" },
    cmd = { "GoDoc" },
    opts = {
      picker = {
        type = "telescope"
      },
      window = {
        type = "vsplit"
      }
    },
    keys = {
      { "<leader>od", "<cmd>GoDoc<CR>", desc = "[O]pen [D]ocumentation (GoDoc)" },
    },
  }
}
