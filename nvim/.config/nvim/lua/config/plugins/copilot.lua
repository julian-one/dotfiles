return {
	{
		-- Copilot (Lua-based for API access)
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = true },
				panel = { enabled = false },
			})
		end,
	},
	{
		-- Copilot Chat
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-lua/plenary.nvim",
		},
		opts = {
			debug = false, -- Enable debugging
			-- See Configuration section for rest
		},
		keys = {
			-- Quick chat with Copilot
			{
				"<leader>aa",
				function()
					return require("CopilotChat").toggle()
				end,
				desc = "Toggle Copilot Chat",
			},
			-- Chat about the selected code
			{
				"<leader>ae",
				function()
					local input = vim.fn.input("Ask Copilot: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").selection })
					end
				end,
				desc = "Ask about selection",
				mode = "v",
			},
			-- Quick actions
			{
				"<leader>ap",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
			-- Code-related shortcuts
			{
				"<leader>ae",
				"<cmd>CopilotChatExplain<cr>",
				desc = "CopilotChat - Explain code",
			},
			{
				"<leader>at",
				"<cmd>CopilotChatTests<cr>",
				desc = "CopilotChat - Generate tests",
			},
			{
				"<leader>ar",
				"<cmd>CopilotChatReview<cr>",
				desc = "CopilotChat - Review code",
			},
			{
				"<leader>af",
				"<cmd>CopilotChatFix<cr>",
				desc = "CopilotChat - Fix code",
			},
			{
				"<leader>ao",
				"<cmd>CopilotChatOptimize<cr>",
				desc = "CopilotChat - Optimize code",
			},
			{
				"<leader>ad",
				"<cmd>CopilotChatDocs<cr>",
				desc = "CopilotChat - Generate docs",
			},
			-- Reset chat
			{
				"<leader>ax",
				"<cmd>CopilotChatReset<cr>",
				desc = "CopilotChat - Reset chat history",
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")

			-- Setup the plugin
			chat.setup(opts)

			-- Setup some useful selections
			vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
				chat.ask(args.args, { selection = select.visual })
			end, { nargs = "*", range = true })

			-- Inline chat with Copilot
			vim.api.nvim_create_user_command("CopilotChatInline", function(args)
				chat.ask(args.args, {
					selection = select.visual,
					window = {
						layout = "float",
						relative = "cursor",
						width = 1,
						height = 0.4,
						row = 1,
					},
				})
			end, { nargs = "*", range = true })
		end,
	},
	{
		-- Copilot integration for blink.cmp
		"giuxtaposition/blink-cmp-copilot",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
	},
}
