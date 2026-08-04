local build_commands = {
  ['LuaSnip'] = { 'make', 'install_jsregexp' },
  ['telescope-fzf-native.nvim'] = { 'make' },
}

local function run_build_command(event)
  local plugin_name = event.data.spec.name
  local change_kind = event.data.kind
  local build_command = build_commands[plugin_name]
  local was_installed_or_updated = change_kind == 'install' or change_kind == 'update'

  if build_command and was_installed_or_updated then
    vim.system(build_command, { cwd = event.data.path }):wait()
  end
end

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('plugin_build_commands', { clear = true }),
  callback = run_build_command,
})

require 'plugins.colorscheme'
require 'plugins.devicons'
require 'plugins.which-key'
require 'plugins.treesitter'
require 'plugins.git'
require 'plugins.diagnostics'
require 'plugins.rainbow'
require 'plugins.blink'
require 'plugins.lsp'
require 'plugins.lualine'
require 'plugins.cmdline'
require 'plugins.telescope'
require 'plugins.go'
require 'plugins.conform'
require 'plugins.hlslens'
require 'plugins.oil'
require 'plugins.quicker'
require 'plugins.tmux'
require 'plugins.ui'

local function remove_unused_plugins()
  local unused_plugin_names = {}

  for _, plugin in ipairs(vim.pack.get()) do
    if not plugin.active then
      table.insert(unused_plugin_names, plugin.spec.name)
    end
  end

  if #unused_plugin_names == 0 then
    return
  end

  vim.pack.del(unused_plugin_names)
  vim.notify('Removed unused plugins: ' .. table.concat(unused_plugin_names, ', '))
end

remove_unused_plugins()
