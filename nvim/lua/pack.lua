vim.g.tmux_navigator_no_mappings = 1

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack_build', { clear = true }),
  desc = 'build plugins that ship compiled artifacts',
  callback = function(ev)
    local name, kind, path = ev.data.spec.name, ev.data.kind, ev.data.path

    if name == 'telescope-fzf-native.nvim' and kind ~= 'delete' then
      vim.system({ 'make' }, { cwd = path }):wait()
    elseif name == 'nvim-treesitter' and kind == 'update' then
      require('nvim-treesitter').update()
    end
  end,
})

vim.pack.add {
  { src = 'https://github.com/mofiqul/vscode.nvim' },

  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },

  { src = 'https://github.com/NMAC427/guess-indent.nvim' },

  { src = 'https://github.com/OXY2DEV/markview.nvim' },
  { src = 'https://github.com/OXY2DEV/helpview.nvim' },

  { src = 'https://github.com/L3MON4D3/LuaSnip' },
  { src = 'https://github.com/rafamadriz/friendly-snippets' },

  { src = 'https://github.com/Saghen/blink.cmp', version = vim.version.range '1.*' },

  { src = 'https://github.com/onsails/lspkind.nvim' },

  { src = 'https://github.com/stevearc/conform.nvim' },

  { src = 'https://github.com/stevearc/oil.nvim' },

  { src = 'https://github.com/lewis6991/gitsigns.nvim' },

  { src = 'https://github.com/nvim-lua/plenary.nvim' },

  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },

  { src = 'https://github.com/j-hui/fidget.nvim' },

  { src = 'https://github.com/christoomey/vim-tmux-navigator' },

  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },

  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

local function clean()
  local inactive = {}

  for _, plugin in ipairs(vim.pack.get()) do
    if not plugin.active then
      table.insert(inactive, plugin.spec.name)
    end
  end

  if #inactive > 0 then
    vim.pack.del(inactive)
  end

  return #inactive
end

clean()

vim.api.nvim_create_user_command('PackClean', function()
  if clean() == 0 then
    vim.notify 'No inactive plugins'
  end
end, { desc = 'Remove plugins not in vim.pack.add() specs' })
