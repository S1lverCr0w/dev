return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "onedark",
		},
		sections = {
			lualine_b = { "branch", "diagnostics" },
			lualine_c = { { "filename", path = 1 } },
			-- ??
			lualine_y = { { "lsp_status" } },
			-- ??
		},
		inactive_sections = {
			lualine_c = { { "filename", path = 1 } },
		},
	},
}
