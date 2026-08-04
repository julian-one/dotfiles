vim.pack.add {
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-frecency.nvim' },
}

local telescope = require 'telescope'
local builtin = require 'telescope.builtin'

local ignored_paths = { 'node_modules/', '%.git/' }

telescope.setup {
  defaults = {
    path_display = { 'truncate', 'filename_first' },
    prompt_prefix = '   ',
    selection_caret = '▍ ',
    entry_prefix = '  ',
    results_title = false,
    dynamic_preview_title = true,
    sorting_strategy = 'ascending',
    layout_config = {
      prompt_position = 'top',
      width = 0.9,
      height = 0.85,
      horizontal = { preview_width = 0.55 },
    },
  },
  extensions = {
    frecency = {
      show_filter_column = false,
    },
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
  pickers = {
    buffers = { theme = 'dropdown', previewer = false },
    live_grep = {
      file_ignore_patterns = ignored_paths,
      additional_args = function(_) return { '--hidden' } end,
    },
    find_files = {
      file_ignore_patterns = ignored_paths,
      hidden = true,
    },
  },
}

telescope.load_extension 'fzf'
telescope.load_extension 'ui-select'
telescope.load_extension 'frecency'

vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy find in current buffer' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Git files' })

vim.keymap.set('n', '<leader>s.', function() telescope.extensions.frecency.frecency { workspace = 'CWD' } end, { desc = 'Search frecent files' })
vim.keymap.set('n', '<leader>s/', function() builtin.live_grep { grep_open_files = true } end, { desc = 'Search in open files' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = 'Search commands' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
vim.keymap.set('n', '<leader>sm', builtin.man_pages, { desc = 'Search man pages' })
vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = 'Search neovim config' })
vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = 'Search quickfix' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Resume last search' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search telescope pickers' })
vim.keymap.set({ 'n', 'x' }, '<leader>sw', builtin.grep_string, { desc = 'Search current word' })
