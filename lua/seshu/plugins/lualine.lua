-- -- Get the lsp of the current buffer, when using native lsp.
local function get_native_lsp()
	local msg = "No Active Lsp"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			-- print(client.name)
			return client.name
		end
	end
	return msg
end

-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

lualine.setup({
	sections = {
		lualine_a = {
			{
				"mode",
				icon = { "" },
			},
		},
		lualine_x = {
			{
				"progress",
			},
		},
		lualine_y = {
			{
				get_native_lsp,
				icon = {
					" LSP",
					align = "left",
					-- color = { fg = "#ffffff", gui = "bold" },
				},
				-- separator = { left = "", right = "" },
			},
			{
				"filetype",
			},
		},
	},
})
