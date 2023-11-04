-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jj to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })

-- copying from vim to system clipboard
keymap.set("v", "<leader>gy", '"+y')

-- Primegean way of adding lines with J
keymap.set("n", "J", "mzJ`z")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- bufferline
keymap.set("n", "<leader>bxl", "<cmd> BufferLineCloseLeft <CR>", { desc = "Close all buffers to left" }) -- close buffers to the left
keymap.set("n", "<leader>bxr", "<cmd> BufferLineCloseRight <CR>", { desc = "Close all buffers to right" }) -- close buffers to the right
keymap.set("n", "<leader>bxx", "<cmd> BufferLineCloseOthers <CR>", { desc = "Close all other buffers" }) -- close all buffers expect current one
keymap.set("n", "<S-b>", "<cmd> enew <CR>") --"烙 new buffer"
keymap.set("n", "<A-.>", "<cmd> BufferLineCycleNext <CR>") --"  cycle next buffer"
keymap.set("n", "<A-,>", "<cmd> BufferLineCyclePrev <CR>") --"  cycle prev buffer"
keymap.set("n", "<A-s-.>", "<cmd> BufferLineMoveNext <CR>") --"  move next buffer"
keymap.set("n", "<A-s-,>", "<cmd> BufferLineMovePrev <CR>") --"  move prev buffer"
keymap.set("n", "<A-f>", "<cmd> BufferLinePick <CR>")
keymap.set("n", "<leader>bx", "<cmd> bp|sp|bn|bd! <CR>", { desc = "Close the current buffer" }) --"	close buffer"
for i = 1, 9 do
	keymap.set("n", "<A-" .. i .. ">", function() -- chosse <A-i> to choose that buffer
		require("bufferline").go_to_buffer(i)
	end)
end

-- trouble
keymap.set("n", "<leader>xx", function()
	require("trouble").toggle()
end)
keymap.set("n", "<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end)
keymap.set("n", "<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end)
keymap.set("n", "<leader>xq", function()
	require("trouble").toggle("quickfix")
end)
keymap.set("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end)
keymap.set("n", "gR", function()
	require("trouble").toggle("lsp_references")
end)
