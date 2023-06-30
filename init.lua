-- Requires in one place
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("seshu.core.keymaps")
require("seshu.plugins.vimtex")
require("lazy").setup("plugins")
require("seshu.plugins.treesitter")
require("seshu.plugins.undotree")
require("seshu.plugins.lualine")
require("seshu.plugins.indent_blankline")
require("seshu.plugins.which-key")
require("seshu.plugins.nvim-cmp")
require("seshu.plugins.luasnip")
require("seshu.lsp.mason")
require("seshu.lsp.lspsaga")
require("seshu.lsp.lspconfig")
require("seshu.lsp.null-ls")
