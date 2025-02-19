return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    icons = {},
    opts = {
      spec = {
        { "<leader>g", name = "+Git" },
        { "<leader>s", name = "+Search" },
        { "<leader>t", name = "+Terminal" },
        { "<leader>c", name = "+Code" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ mode = "n", auto = true })
        end,
        desc = "Show Normal Mode Keymaps",
      },
    },
  }
}
