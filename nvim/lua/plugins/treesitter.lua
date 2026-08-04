local ts = require 'nvim-treesitter'

ts.install {
  'bash',
  'c',
  'cmake',
  'cpp',
  'css',
  'diff',
  'dockerfile',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'html',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'make',
  'markdown',
  'markdown_inline',
  'query',
  'sql',
  'svelte',
  'templ',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

local available = ts.get_available()
local attempted = {}

local function start_treesitter(buf, lang)
  vim.treesitter.start(buf, lang)

  if vim.treesitter.query.get(lang, 'indents') then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local function install_then_retry(buf, lang)
  if attempted[lang] then
    return
  end
  attempted[lang] = true

  ts.install(lang):await(function()
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_exec_autocmds('FileType', { buffer = buf })
    end
  end)
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter_start', { clear = true }),
  desc = 'start treesitter, installing the parser on demand',
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang then
      return
    end

    if vim.treesitter.language.add(lang) then
      start_treesitter(ev.buf, lang)
    elseif vim.tbl_contains(available, lang) then
      install_then_retry(ev.buf, lang)
    end
  end,
})
