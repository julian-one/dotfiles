local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	-- Store the plugin list to avoid calling the getter multiple times
	local plugins = vim.pack.get()

	-- Tag plugins that are active anywhere in the tree
	for _, plugin in ipairs(plugins) do
		local name = plugin.spec.name
		active_plugins[name] = active_plugins[name] or plugin.active
	end

	-- Collect names of plugins that are never active, avoiding duplicates
	for _, plugin in ipairs(plugins) do
		local name = plugin.spec.name
		if not active_plugins[name] and not vim.tbl_contains(unused_plugins, name) then
			table.insert(unused_plugins, name)
		end
	end

	if #unused_plugins == 0 then
		vim.notify("No unused plugins found to clean.", vim.log.levels.INFO)
		return
	end

	-- Present an itemized list of what is about to be wiped
	local prompt =
		string.format("Remove %d unused plugins?\n- %s", #unused_plugins, table.concat(unused_plugins, "\n- "))

	local choice = vim.fn.confirm(prompt, "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
		vim.notify(string.format("Successfully cleaned %d unused plugins.", #unused_plugins), vim.log.levels.INFO)
	end
end

vim.keymap.set("n", "<leader>cu", pack_clean, { desc = "[C]lean [U]nused plugins" })
