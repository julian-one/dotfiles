return {
  'vim-test/vim-test',
  dependencies = {
    'preservim/vimux',
  },
  config = function()
    vim.keymap.set('n', '<leader>tt', ':TestNearest<CR>')
    vim.keymap.set('n', '<leader>tf', ':TestFile<CR>')
    vim.keymap.set('n', '<leader>ts', ':TestSuite<CR>')
    vim.keymap.set('n', '<leader>tl', ':TestLast<CR>')
    vim.keymap.set('n', '<leader>tv', ':TestVisit<CR>')

    -- Set a custom strategy for Go tests to include options
    vim.cmd [[
      function! GoTestStrategy(cmd)
        execute 'VimuxRunCommand("'.a:cmd.' -v -count=1 -coverprofile=coverage.out")'
      endfunction
      let g:test#go#runner = 'gotest'
      let g:test#custom_strategies = {'gotest': function('GoTestStrategy')}
      let g:test#strategy = 'gotest'
    ]]
  end,
}
