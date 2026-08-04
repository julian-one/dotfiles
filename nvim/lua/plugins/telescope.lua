local telescope = require 'telescope'

telescope.setup {
  extensions = {
    ['ui-select'] = { require('telescope.themes').get_dropdown() },
  },
}

telescope.load_extension 'fzf'
telescope.load_extension 'ui-select'

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy find in current buffer' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Git files' })

vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search recent files' })
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
