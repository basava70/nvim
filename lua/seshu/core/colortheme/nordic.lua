-- Config for Alex nordic theme
require 'nordic' .setup {
    bright_border = false,
	telescope = {
		style = 'classic',
	},
	bold_keywords = false,
	italic_comments = true,
	transparent_bg = false,
	override = {},
    cursorline = {
        theme = 'dark',
        bold = false
    },
    noice = {
        style = 'classic'
    },
}

-- Load the scheme.
vim.cmd.colorscheme 'nordic'
