return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_enable = {
				exclude = {
					--needs external plugin
					"jdtls",
				},
			},
		},
	},
	-- important external plugin for java (eclipse ide)
	{ "mfussenegger/nvim-jdtls" },
}

--[[
-- add the following lines to the lsp config for mason-lspconfig for a more modular approach and call this file
"williamboman/mason-lspconfig.nvim",
-- -- for java jdtls ide: jdtls needs to be installed by mason but not initialized by mason
require("java.jdtls_lsp"),



-- or add the follwoing lines for less modular approach
-- -- for java jdtls ide: jdtls needs to be installed by mason but not initialized by mason
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
