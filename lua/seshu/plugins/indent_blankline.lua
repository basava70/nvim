vim.opt.termguicolors = true
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#5e81ac gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#5e81ac gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#5e81ac gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#5e81ac gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#5e81ac gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#5e81ac gui=nocombine]])
vim.cmd([[highlight IndentBlanklineContextChar guifg=#88c0d0 gui=nocombine]])

-- vim.g.indent_blankline_use_treesitter_scope = true
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup({
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = true,
	show_end_of_line = true,
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
})
