-- add this file to init.lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function(args)
		require("java.jdtls_setup").setup()
	end,
})
--[[
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
