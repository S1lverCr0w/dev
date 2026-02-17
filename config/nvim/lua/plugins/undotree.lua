return {
	"mbbill/undotree",
	keys = {
		{
			"<leader>u",
			vim.cmd.UndotreeToggle,
			desc = "Undotree: panel show/hide",
		},
	},

	-- old set up
	-- config = function()
	-- 	vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
	-- 	desk = "Undo tree"
	-- end,
}
