-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
	return
end

saga.setup({
	-- keybinds for navigation in lspsaga window
	scroll_preview = { scroll_down = "<C-j>", scroll_up = "<C-k>" },
	-- use enter to open file with definition preview
	--[[ definition = {
		edit = "<CR>",
	}, ]]
	ui = {
		-- This option only works in Neovim 0.9
		title = true,
		-- Border type can be single, double, rounded, solid, shadow.
		border = "rounded",
		winblend = 0,
		expand = "",
		collapse = "",
		code_action = "💡",
		incoming = " ",
		outgoing = " ",
		hover = " ",
		colors = {
			normal_bg = "#BF616A",
		},
	},
	finder = {
		max_height = 0.5,
		min_width = 30,
		force_max_height = false,
		keys = {
			jump_to = "p",
			expand_or_jump = "o",
			vsplit = "s",
			split = "i",
			tabe = "t",
			tabnew = "r",
			quit = { "q", "<ESC>" },
			close_in_preview = "<ESC>",
		},
	},
	definition = {
		edit = "<C-y>",
		-- edit = "<C-c>o",
		vsplit = "<C-c>v",
		split = "<C-c>i",
		tabe = "<C-c>t",
		quit = "q",
	},
})
