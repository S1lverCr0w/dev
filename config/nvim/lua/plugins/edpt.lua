-- stylua: ignore
local function gh(repo) return 'https://github.com/' .. repo end

-- vim.pack.add { gh 'S1lverCr0w/edpt.nvim' }
-- vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
-- https://github.com/S1lverCr0w/edpt.nvim/tree/dev

-- https://github.com/datsfilipe/nvim-colorscheme-template/tree/main

vim.pack.add { { src = gh 'S1lverCr0w/edpt.nvim', version = "devel", } }
-- require("onedark").setup({
-- 	-- style = 'light',
-- 	-- style = 'dark',
-- })
-- require("onelight").setup()
require("onedark").setup()
-- vim.cmd.colorscheme 'onedark'
-- vim.cmd.colorscheme 'onelight'

-- require('e_onedark').setup({
-- 	-- theme = 'light',
-- 	theme = 'dark',
-- 	-- transparent = 'true',
-- })
-- vim.cmd.colorscheme 'e_onedark'

-- vim.pack.add { gh 'S1lverCr0w/onedark.nvim' }
-- require("onedarkpro").setup({
-- 	colors = {
-- 		onedark = { bg = '#1b1d22', }, -- enryu bg 0
-- -- 		-- onedark = { bg = '#16181d', }, -- enryu bg 1
-- 		onelight = { bg = "#f5f5f5" }, -- minimalist paper
-- 		-- onelight = { bg = "#e6e6e6" }, -- 90% value
-- 		-- onelight = { bg = "#d9d9d9" }, -- 85% value
-- 		-- onelight = { bg = "#eff1f5" }, -- soft cool gray
-- 	},
-- -- 	filetypes = { false },
-- -- 	-- plugins = { false },
-- -- 	plugins = { false, treesitter = { true }, },
-- })
--
-- require 'OneDarkProDarkify'						-- custom script to modfy the onedarkpro theme
-- vim.cmd.colorscheme 'onedark'
-- vim.cmd.colorscheme 'onelight'
