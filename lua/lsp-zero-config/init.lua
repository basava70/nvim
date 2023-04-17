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

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
  return
end

-- import lspsaga safely
local saga_status, saga = pcall(require, "lspsaga")
if not saga_status then
  return
end


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
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

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings,
  -- sources for autocompletion
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'luasnip'},
  },
  --[[ mapping = {
    ['<C-j>'] = cmp_action.luasnip_jump_forward(),
    ['<C-k>'] = cmp_action.luasnip_jump_backward(),
  },  ]]
  -- configure lspkind for vs-code like icons
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      -- maxwidth = 50,
      ellipsis_char = "...",
    }),
  },
})

saga.setup({
  -- keybinds for navigation in lspsaga window
  scroll_preview = { scroll_down = "<C-j>", scroll_up = "<C-k>" },
  -- use enter to open file with definition preview
  definition = {
    edit = "<CR>",
  },
    ui = {
    -- This option only works in Neovim 0.9
    title = true,
    -- Border type can be single, double, rounded, solid, shadow.
    border = "rounded",
    winblend = 0,
    expand = "",
    collapse = "",
    code_action = "💡",
    incoming = " ",
    outgoing = " ",
    hover = ' ',
    colors = {
      normal_bg = '#BF616A'
    }
  }, 
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
end)

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

