return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")
		---@diagnostic disable-next-line: missing-parameter
		harpoon:setup()
		local function map(lhs, rhs, opts)
			vim.keymap.set("n", lhs, rhs, opts or {})
		end
		map("<leader>a", function()
			harpoon:list():append()
		end)
		map("<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		for i = 1, 9 do
			map("<A-" .. i .. ">", function() -- chosse <A-i> to choose that buffer
				harpoon:list():select(i)
			end)
		end
	end,
}
