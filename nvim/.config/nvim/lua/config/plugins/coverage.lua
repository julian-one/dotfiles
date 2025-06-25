local function waitUntilLoaded()
	local coverageLoaded = false

	return function(cov, f)
		if not coverageLoaded then
			cov.load()
			coverageLoaded = true

			local timer = vim.loop.new_timer()
			if timer then
				timer:start(500, 0, function()
					vim.schedule(function()
						f()
					end)
				end)
			end
		else
			f()
		end
	end
end

WaitUntilLoaded = waitUntilLoaded()

local function toggle(cov)
	return WaitUntilLoaded(cov, cov.toggle)
end

local function summary(cov)
	return WaitUntilLoaded(cov, cov.summary)
end

return {
	"andythigpen/nvim-coverage",
	lazy = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neotest/neotest",
	},
	keys = {
		{
			"<leader>cs",
			function()
				local cov = require("coverage")
				summary(cov)
			end,
			desc = "Coverage Summary",
		},
		{
			"<leader>cv",
			function()
				local cov = require("coverage")
				toggle(cov)
			end,
			desc = "Coverage Toggle",
		},
	},
	config = function()
		require("coverage").setup({
			auto_reload = true,
		})
	end,
}
