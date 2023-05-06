local wk = require("which-key")

wk.register(mappings, opts)
wk.register({
	f = {
		name = "file", -- optional group name
		f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
		g = { "<cmd>Telescope live_grep<cr>", "search grep files" },
		G = { "<cmd>Telescope git_files<cr>", "search git files" },
		b = { "<cmd>Telescope buffers<cr>", "search buffers" },
		h = { "<cmd>Telescope help_tags<cr>", "search help_tags" },
	},
	name = "general",
	-- e = { ":NvimTreeToggle<cr>", "Toggle Nvim-tree" },
	u = { ":UndotreeToggle<cr>", "Toggle UndoTree" },

	g = {
		name = "git", -- git related
		-- s = { "vim.cmd.Git", "Open git status"},
	},

	b = {
		name = "buffer movements",
		j = { "<cmd>BufferLinePick<cr>", "Jump" },
		f = { "<cmd>Telescope buffers<cr>", "Find" },
		b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
		n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
		-- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
		e = {
			"<cmd>BufferLinePickClose<cr>",
			"Pick which buffer to close",
		},
		h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
		l = {
			"<cmd>BufferLineCloseRight<cr>",
			"Close all to the right",
		},
		D = {
			"<cmd>BufferLineSortByDirectory<cr>",
			"Sort by directory",
		},
		L = {
			"<cmd>BufferLineSortByExtension<cr>",
			"Sort by language",
		},
	},

	--[[ l = {
    name = "diagnostic/lsp",
    d = { "vim.lsp.buf.definition()", "Goto definition"},
    w = { "vim.lsp.buf.workspace_symbol()", "Goto workspace_symbol"},
    c = { "vim.lsp.buf.code_action()", "Code Action"},
    r = { "vim.lsp.buf.references()", "References"},
    R = { "vim.lsp.buf.rename()", "Rename lsp buffer"},
  }, ]]
}, { prefix = "<leader>" })
