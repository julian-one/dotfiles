return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    icons = {},
    opts = {
      spec = {
        { "<leader>g", name = "[G]it" },
        { "<leader>s", name = "[S]earch" },
        { "<leader>t", name = "[T]erminal" },
        { "<leader>c", name = "[C]ode" },
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
