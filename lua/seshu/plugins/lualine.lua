return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "linrongbin16/lsp-progress.nvim" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local function LspIcon()
			local active_clients_count = #vim.lsp.get_active_clients()
			return active_clients_count > 0 and " LSP" or ""
		end

		local function LspStatus()
			return require("lsp-progress").progress({
				format = function(messages)
					local active_clients = vim.lsp.get_active_clients()
					local client_count = #active_clients
					if #messages > 0 then
						return " LSP:" .. client_count .. " " .. table.concat(messages, " ")
					end
					if #active_clients <= 0 then
						return " LSP:" .. client_count
					else
						local client_names = {}
						for i, client in ipairs(active_clients) do
							if client and client.name ~= "" then
								table.insert(client_names, "[" .. client.name .. "]")
								-- print("client[" .. i .. "]:" .. vim.inspect(client.name))
							end
						end
						return " LSP:" .. client_count .. " " .. table.concat(client_names, " ")
					end
				end,
			})
		end

		lualine.setup({
			sections = {
				lualine_a = {
					{
						"mode",
						icon = { "" },
					},
				},
				lualine_c = {
					-- invoke `progress` here.
					LspStatus,
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
		-- listen lsp-progress event and refresh lualine
		vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			group = "lualine_augroup",
			pattern = "LspProgressStatusUpdated",
			callback = require("lualine").refresh,
		})
	end,
}
