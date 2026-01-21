return {
	"S1lverCr0w/edpt-dark.nvim",
	lazy = false,
	priority = 1000,
	init = function()
		-- vim.g.gruvbox_material_enable_italic = true
		vim.cmd.colorscheme("onedark")
		-- vim.cmd.hi('Comment gui=none')
	end,
}
