-- stylua: ignore
local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'S1lverCr0w/edpt.nvim', version = "dev", } }
-- require("onelight").setup({
-- 	-- style = 'light',
-- 	-- style = 'dark',
-- })

require("onelight").setup({}) -- lua command
-- require("onedark").setup({})
-- vim.cmd.colorscheme 'onedark' -- vim command
-- vim.cmd.colorscheme 'onelight'
