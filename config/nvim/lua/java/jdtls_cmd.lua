-- NOTE: add this line to init.lua
-- require("java.jdtls_cmd")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function(args)
		require("java.jdtls_setup").setup()
	end,
})

--[[
-- NOTE: this is only for the not so mudular approach. For modular approach check jdtls_lsp.lua

-- add the following lines to the lsp confin so jdtls can be installed by mason but initialized by jdtls script
	"williamboman/mason-lspconfig.nvim",
	opts = {
		automatic_enable = {
			exclude = {
				--needs external plugin
				"jdtls",
			},
		},
	},
	]]
