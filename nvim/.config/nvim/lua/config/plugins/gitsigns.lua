return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        local map = function(mode, key, cmd, desc)
          vim.keymap.set(mode, key, cmd, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then vim.cmd.normal { ']c', bang = true } else gitsigns.nav_hunk 'next' end
        end, 'Jump to next git [C]hange')

        map('n', '[c', function()
          if vim.wo.diff then vim.cmd.normal { '[c', bang = true } else gitsigns.nav_hunk 'prev' end
        end, 'Jump to previous git [C]hange')

        -- Actions
        map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
          'Git [S]tage hunk')
        map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
          'Git [R]eset hunk')
        map('n', '<leader>hs', gitsigns.stage_hunk, 'Git [S]tage hunk')
        map('n', '<leader>hr', gitsigns.reset_hunk, 'Git [R]eset hunk')
        map('n', '<leader>hS', gitsigns.stage_buffer, 'Git [S]tage buffer')
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, 'Git [U]ndo stage hunk')
        map('n', '<leader>hR', gitsigns.reset_buffer, 'Git [R]eset buffer')
        map('n', '<leader>hp', gitsigns.preview_hunk, 'Git [P]review hunk')
        map('n', '<leader>hb', gitsigns.blame_line, 'Git [B]lame line')
        map('n', '<leader>hd', gitsigns.diffthis, 'Git [D]iff against index')
        map('n', '<leader>hD', function() gitsigns.diffthis '@' end, 'Git [D]iff against last commit')

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, '[T]oggle git show [B]lame line')
        map('n', '<leader>tD', gitsigns.toggle_deleted, '[T]oggle git show [D]eleted')
      end,
    },
  },
}

