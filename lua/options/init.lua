-- Leader map
vim.g.mapleader = " "

-- map esc to jj
local options = { noremap = true }
vim.keymap.set("i", "jj", "<Esc>", options)
-- vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeFindFileToggle)
vim.keymap.set("n", "<leader>gi", "gg=G''")
vim.keymap.set("v", "<leader>gy", "\"+y")



--primegean keymaps vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim-maximizer
-- vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximizatio

vim.opt.splitright = true
vim.opt.splitbelow = true

-- random options
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.o.cursorline = true

vim.o.cmdheight = 2

vim.o.syntax = true


