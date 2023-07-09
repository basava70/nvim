-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- import luasnip plugin safely
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

-- load vs-code like snippets from plugins (e.g. friendly-snippets)
require("luasnip/loaders/from_vscode").lazy_load()
-- Load snippets from ~/.config/nvim/LuaSnip/
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/seshu/lspsnip/" })

vim.opt.completeopt = "menu,menuone,noselect"
vim.cmd([[ highlight! default link CmpItemKind CmpItemMenuDefault ]])

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
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
})
