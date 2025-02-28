return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            { 'nvim-tree/nvim-web-devicons',              enabled = vim.g.have_nerd_font },
        },
        config = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')

            telescope.setup({
                defaults = {
                    sorting_strategy = "ascending",
                    layout_config = { prompt_position = "top" },
                    file_ignore_patterns = { "node_modules", ".git/" },
                },
                pickers = {
                    find_files = {
                        theme = "dropdown",
                        previewer = false,
                    },
                    buffers = {
                        theme = "dropdown",
                        previewer = false,
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            telescope.load_extension('fzf') -- load fzf-native extension

            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sc', function()
                builtin.find_files({ cwd = vim.fn.stdpath("config") })
            end, { desc = '[S]earch [C]onfig' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
        end
    }
}
