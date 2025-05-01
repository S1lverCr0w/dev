-- make sure to commen out "vim.vmd.colorscheme 'tokyonight'" r the theme might not load

return {
	{
		"S1lverCr0w/edpt-dark.nvim",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("onedark")
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et- See the kickstart.nvim README for more information
