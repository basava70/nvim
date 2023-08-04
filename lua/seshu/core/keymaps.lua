-- Leader map
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness
-- map esc to jj
local options = { noremap = true }
keymap.set("i", "jj", "<Esc>", options)
keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
keymap.set("n", "<leader>o", function()
	if vim.bo.filetype == "NvimTree" then
		vim.cmd.wincmd("p")
	else
		vim.cmd("NvimTreeFocus")
	end
end)

keymap.set("n", "<leader>ps", "<cmd>PackerSync<cr>") -- PackerSync

keymap.set("n", "<leader>gi", "gg=G''")
keymap.set("v", "<leader>gy", '"+y')
keymap.set("n", "<leader>nl", vim.cmd.NullLsInfo)
keymap.set("n", "<leader>li", vim.cmd.LspInfo)
keymap.set("n", "<leader>ww", [[:set spell<CR>]])

-- Primegean keymaps keymap.set("v", "J", ":m '>+1<CR>gv=gv") keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fG", "<cmd>Telescope git_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- bufferline
keymap.set("n", "<S-b>", "<cmd> enew <CR>") --"烙 new buffer"
keymap.set("n", "<A-.>", "<cmd> BufferLineCycleNext <CR>") --"  cycle next buffer"
keymap.set("n", "<A-,>", "<cmd> BufferLineCyclePrev <CR>") --"  cycle prev buffer"
keymap.set("n", "<A-s-.>", "<cmd> BufferLineMoveNext <CR>") --"  cycle next buffer"
keymap.set("n", "<A-s-,>", "<cmd> BufferLineMovePrev <CR>") --"  cycle prev buffer"
keymap.set("n", "<A-f>", "<cmd> BufferLinePick <CR>")
keymap.set("n", "<leader>x", "<cmd> bp|sp|bn|bd! <CR>") --"	close buffer"
for i = 1, 9 do
	keymap.set("n", "<A-" .. i .. ">", function()
		require("bufferline").go_to_buffer(i)
	end)
	-- keymap.set("n", "<A-" .. i .. ">", "<cmd>" .. i .. "tabn<CR>")
end

-- dap
keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>") -- toggle breakpoint
keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>") -- start or continue debugger
keymap.set("n", "<leader>dso", "<cmd> DapStepOut <CR>") -- start or continue debugger
keymap.set("n", "<leader>dsi", "<cmd> DapStepInto <CR>") -- start or continue debugger
keymap.set("n", "<leader>do", "<cmd> DapStepOver <CR>") -- start or continue debugger
keymap.set("n", "<leader>de", "<cmd> DapTerminate <CR>") -- start or continue debugger
