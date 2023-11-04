return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		local nvim_web_devicons = require("nvim-web-devicons")
		nvim_web_devicons.set_icon({
			cu = {
				icon = "",
				color = "#f34b7d",
				cterm_color = "65",
				name = "Cuda",
			},
		})
	end,
}
