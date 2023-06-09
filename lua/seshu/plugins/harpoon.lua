vim.api.nvim_create_autocmd({ "filetype" }, {
	pattern = "harpoon",
	callback = function()
		vim.cmd([[highlight HarpoonBorder guibg= #2e3440]])
		vim.cmd([[highlight HarpoonWindow guibg= #2e3440]])
	end,
})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<A-1>", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<A-2>", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<A-3>", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<A-4>", function()
	ui.nav_file(4)
end)
vim.keymap.set("n", "<A-5>", function()
	ui.nav_file(5)
end)
vim.keymap.set("n", "<A-6>", function()
	ui.nav_file(6)
end)
vim.keymap.set("n", "<A-7>", function()
	ui.nav_file(7)
end)
vim.keymap.set("n", "<A-8>", function()
	ui.nav_file(8)
end)

--[[ local tmux = require("haroon.tmux")

vim.keymap.set("n", "<
lua require("harpoon.tmux").gotoTerminal(1) ]]
