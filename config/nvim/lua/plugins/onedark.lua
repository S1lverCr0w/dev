local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'S1lverCr0w/onedark.nvim' }
require("onedarkpro").setup({
	colors = {
		onedark = { bg = "#1b1d22" },
		onelight = { bg = "#f5f5f5" }, -- minimalist paper
		-- onelight = { bg = "#e6e6e6" }, -- 90% value
		-- onelight = { bg = "#d9d9d9" }, -- 85% value
		-- onelight = { bg = "#eff1f5" }, -- soft cool gray
	}
})
vim.cmd.colorscheme 'onedark'
-- vim.cmd.colorscheme 'onelight'
