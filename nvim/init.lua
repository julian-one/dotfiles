vim.loader.enable() -- byte-cache Lua modules (Neovim 0.9+)

require("options") -- vim.opt + mapleader (must be first)
require("keymaps") -- global keymaps
require("diagnostics")
require("plugins") -- vim.pack.add() + all plugin configs, in dependency order
require("autocmds")
require("terminal")
require("clean")
