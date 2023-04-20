require("luasnip").config.set_config({ -- Setting LuaSnip config

	-- Enable autotriggered snippets
	enable_autosnippets = true,

	-- repeated events
	update_events = "TextChanged,TextChangedI",

	-- Use Tab (or some other key if you prefer) to trigger visual selection
	store_selection_keys = "<Tab>",
})

vim.cmd([[
" Use Tab to expand
imap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
smap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
]])
