return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			-- setup must be called before loading
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"catppuccin/nvim",
		lazy = true,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			})
			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
