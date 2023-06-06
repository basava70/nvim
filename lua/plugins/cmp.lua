return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			enable_autosnippets = true,
			-- repeated events
			update_events = "TextChanged,TextChangedI",
			-- Use Tab (or some other key if you prefer) to trigger visual selection
			store_selection_keys = "<Tab>",
		},
		config = function()
			vim.cmd([[
        " Use Tab to expand
         imap <silent><expr> kk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'kk'
         smap <silent><expr> kk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'kk'
         ]])
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = "InsertEnter",
		opts = function()
			local cmp = require("cmp")
			local snip_status_ok, luasnip = pcall(require, "luasnip")
			local lspkind_status_ok, lspkind = pcall(require, "lspkind")
			if not snip_status_ok then
				return
			end
			local border_opts = {
				border = "single",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
			}

			return {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(border_opts),
					documentation = cmp.config.window.bordered(border_opts),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
					["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
					["<C-e>"] = cmp.mapping.abort(), -- close completion window
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				}),
				-- sources for autocompletion
				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1000 }, -- lsp
					{ name = "luasnip", option = { show_autosnippets = true }, priority = 750 }, -- snippets
					{ name = "buffer", priority = 500 }, -- text within current buffer
					{ name = "path", priority = 250 }, -- file system paths
					-- { name = "omni" }, -- for latex omni
				}),
				-- configure lspkind for vs-code like icons
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			}
		end,
		config = function()
			-- load vs-code like snippets from plugins (e.g. friendly-snippets)
			require("luasnip/loaders/from_vscode").lazy_load()
			-- Load snippets from ~/.config/nvim/LuaSnip/
			require("luasnip.loaders.from_lua").lazy_load({
				paths = "~/.config/nvim/lua/plugins/configs/luasnip_all.lua",
			})

			vim.opt.completeopt = "menu,menuone,noselect"
			vim.cmd([[ highlight! default link CmpItemKind CmpItemMenuDefault ]])
		end,
	},
}
