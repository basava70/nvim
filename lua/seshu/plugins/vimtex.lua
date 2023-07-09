-- PDF Viewer:
-- http://manpages.ubuntu.com/manpages/trusty/man5/zathurarc.5.html
vim.cmd([[filetype plugin indent on]])
vim.g["vimtex_view_method"] = "zathura"
vim.g["vimtex_quickfix_mode"] = 2
vim.g.vimtex_quickfix_autoclose_after_keystrokes = 2

-- Ignore mappings
vim.g["vimtex_mappings_enabled"] = 1

-- Auto Indent
vim.g["vimtex_indent_enabled"] = 1

-- Syntax highlighting
vim.g.vimtex_syntax_enabled = 1
vim.g.vimtex_syntax_conceal_disable = 1
-- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
-- Error suppression:
-- https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt

--[[ vim.g['vimtex_log_ignore'] = ({
  'Underfull',
  'Overfull',
  'specifier changed to',
  'Token not allowed in a PDF string',
}) ]]

-- vim.g.vimtex_complete_bib = 1
vim.cmd([[let g:vimtex_grammar_textidote = {'jar': '/opt/textidote/textidote.jar'}]])

vim.g.vimtex_quickfix_ignore_filters = {
	"Missing",
	"hyperref",
	"Warning",
	"Underfull",
	"Overfull",
}

-- vim.g['vimtex_context_pdf_viewer'] = 'okular'

-- vim.g['vimtex_complete_enabled'] = 1
vim.g.vimtex_compiler_latexmk_engines = {
	_ = "-pdflatex",
}
vim.g["vimtex_compiler_progname"] = "nvr"
vim.g.maplocalleader = " "
