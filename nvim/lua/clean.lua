local function pack_clean()
	local active_plugins = {}

	-- Tag plugins that are active anywhere in the tree
	for _, plugin in ipairs(vim.pack.get()) do
		local name = plugin.spec.name
		active_plugins[name] = active_plugins[name] or plugin.active
	end

	-- Collect names of plugins that are never active
	local unused_plugins = {}
	for name, active in pairs(active_plugins) do
		if not active then
			table.insert(unused_plugins, name)
		end
	end
	table.sort(unused_plugins)

	if #unused_plugins == 0 then
		vim.notify("No unused plugins found to clean.", vim.log.levels.INFO)
		return
	end

	-- Present an itemized list of what is about to be wiped
	local prompt = string.format(
		"Remove %d unused plugins?\n- %s",
		#unused_plugins,
		table.concat(unused_plugins, "\n- ")
	)

	local choice = vim.fn.confirm(prompt, "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
		vim.notify(
			string.format("Successfully cleaned %d unused plugins.", #unused_plugins),
			vim.log.levels.INFO
		)
	end
end

vim.api.nvim_create_user_command("PackClean", pack_clean, {
	desc = "Remove unused packed plugins",
})

vim.keymap.set("n", "<leader>P", pack_clean, { desc = "[P]ackage clean unused plugins" })
