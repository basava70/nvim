return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		window = {
			border = { "", "▔", "", "", "", " ", "", "" },
			margin = { 0, 0, 1, 0 },
			padding = { 0, 0, 0, 0 },
		},
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
}
