-- See `:help ibl`
vim.pack.add { 'https://github.com/lukas-reineke/indent-blankline.nvim' } -- Add indentation guides even on blank lines
require('ibl').setup {
	indent = {
		char = "│",
		-- highlight = highlight, -- test
	},
	-- disable the scope underline and scope highlight
	scope = { enabled = false },
}
