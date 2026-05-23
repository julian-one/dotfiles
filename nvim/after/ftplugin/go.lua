-- Go-specific keymaps (go.nvim commands + godoc.nvim). Buffer-local.
local map = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { buffer = 0, desc = "[C]ode Go: " .. desc })
end

map("<leader>cie", "<cmd>GoIfErr<cr>", "[I]f [E]rr")
map("<leader>cfs", "<cmd>GoFillStruct<cr>", "[F]ill [S]truct")
map("<leader>cfw", "<cmd>GoFillSwitch<cr>", "[F]ill s[W]itch")
map("<leader>cii", "<cmd>GoImpl<cr>", "[I]mpl [I]nterface")
map("<leader>cta", "<cmd>GoAddTag<cr>", "[T]ag [A]dd")
map("<leader>ctr", "<cmd>GoRmTag<cr>", "[T]ag [R]emove")
map("<leader>ctm", "<cmd>GoModifyTag<cr>", "[T]ag [M]odify")
map("<leader>cic", "<cmd>GoCmt<cr>", "[I]nsert [C]omment")
map("<leader>cga", "<cmd>GoAlt<cr>", "[G]o [A]lternate file")
map("<leader>cd", "<cmd>GoDoc<cr>", "[C]ode Go [D]oc")
