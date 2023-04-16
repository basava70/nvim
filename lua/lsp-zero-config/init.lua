local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  --'typescript-language-server',
  'clangd',
  'texlab',
  'rust_analyzer',
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-j>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-k>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

local cmp_action = require('lsp-zero').cmp_action()

vim.cmd[[
" Use Tab to expand
imap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
smap <silent><expr> jk luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : 'jk'
]]
-- Somewhere in your Neovim startup, e.g. init.lua
require("luasnip").config.set_config({ -- Setting LuaSnip config

-- Enable autotriggered snippets
enable_autosnippets = true,

-- repeated events
update_events = 'TextChanged,TextChangedI',

-- Use Tab (or some other key if you prefer) to trigger visual selection
store_selection_keys = "<Tab>",
})




require('luasnip.loaders.from_vscode').lazy_load()

-- Load snippets from ~/.config/nvim/LuaSnip/
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/lspsnip/"})


cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  mapping = {
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})


cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", vim.cmd([[autocmd CursorHold <buffer> lua OpenDiagFloat()]]))
  -- function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

  --vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)


OpenDiagFloat = function ()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      return
    end
  end
  vim.diagnostic.open_float({focusable = false})
end

require('lspconfig').clangd.setup({
  single_file_support = false,
  on_attach = function(client, bufnr)
    print('Using clangd')
  end
})
require('lspconfig').texlab.setup({
  single_file_support = false,
  on_attach = function(client, bufnr)
    print('Using texlab')
  end
})

lsp.set_sign_icons({
  error = '✘',
  warn = '▲',
  hint = '⚑',
  info = '»'
})


lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})

