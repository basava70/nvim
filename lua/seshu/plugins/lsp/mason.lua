-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"clangd",
		"texlab",
		"ltex",
		"lua_ls",
		"pyright",
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"clang_format", -- cpp formatter
		"cmake_format", -- cmake formatter
		"latexindent", -- tex formatter
		"bibclean", -- bib formatter

		"chktex", -- tex linter
		"cmakelint", -- cmake linter
		"cpplint", -- cpp linter

		"black", -- python formatter
		"mypy", -- python
		"ruff", --python
    "debugpy", -- python debugger
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})