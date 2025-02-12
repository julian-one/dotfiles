return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua" }, 
        auto_install = false, -- might want to flip this...

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

