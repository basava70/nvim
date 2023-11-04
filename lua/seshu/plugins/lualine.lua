return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		-------------------------------------------------------------
		-- Lsp stuff --
		local function getLspName()
			local buf_clients = vim.lsp.buf_get_clients()
			local buf_ft = vim.bo.filetype
			if next(buf_clients) == nil then
				return "  No servers"
			end
			local buf_client_names = {}

			for _, client in pairs(buf_clients) do
				if client.name ~= "null-ls" then
					table.insert(buf_client_names, " " .. client.name)
				end
			end

			local lint_s, lint = pcall(require, "lint")
			if lint_s then
				for ft_k, ft_v in pairs(lint.linters_by_ft) do
					if type(ft_v) == "table" then
						for _, linter in ipairs(ft_v) do
							if buf_ft == ft_k then
								table.insert(buf_client_names, " " .. linter)
							end
						end
					elseif type(ft_v) == "string" then
						if buf_ft == ft_k then
							table.insert(buf_client_names, ft_v)
						end
					end
				end
			end

			local ok, conform = pcall(require, "conform")
			local formatters = table.concat(conform.formatters_by_ft[vim.bo.filetype], " ")
			if ok then
				for formatter in formatters:gmatch("%w+") do
					if formatter then
						table.insert(buf_client_names, "󰉠 " .. formatter)
					end
				end
			end

			local hash = {}
			local unique_client_names = {}

			for _, v in ipairs(buf_client_names) do
				if not hash[v] then
					unique_client_names[#unique_client_names + 1] = v
					hash[v] = true
				end
			end
			local language_servers = table.concat(unique_client_names, ", ")

			return language_servers
		end

		local lsp = {
			function()
				return getLspName()
			end,
		}
		-------------------------------------------------------------

		local space = {
			function()
				return " "
			end,
		}

		local filename = {
			"filename",
		}

		local filetype = {
			"filetype",
			icons_enabled = false,
		}

		local branch = {
			"branch",
		}

		lualine.setup({
			sections = {
				lualine_a = {
					{
						"mode",
						icon = { "" },
					},
				},
				lualine_b = { "branch", "diff" },
				lualine_c = { "diagnostics" },
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "filetype" },
				},
				lualine_y = { "filename" },
				lualine_z = {
					lsp,
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
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
