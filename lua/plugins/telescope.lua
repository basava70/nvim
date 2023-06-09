return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	-- or                            , branch = '0.1.x',
	dependencies = { { "nvim-lua/plenary.nvim" } },
	event = "VimEnter",
	config = function()
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fG", builtin.git_files, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		-- vim.keymap.set("i", "<C-j>", actions.move_selection_next, {})
		-- vim.keymap.set("i", "<C-k>", actions.move_selection_previous, {})
	end,
}
