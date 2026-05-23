require("vscode").setup({
	style = "dark",
	italic_comments = true,
})
local ok = pcall(vim.cmd.colorscheme, "vscode")
if not ok then
	vim.cmd.colorscheme("habamax")
end

require("colorizer").setup({})
