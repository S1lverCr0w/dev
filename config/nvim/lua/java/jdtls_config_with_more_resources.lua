local M = {}

function M.setup()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	-- concatenate path
	local workspace_dir = vim.fn.stdpath("data")
		.. package.config:sub(1, 1)
		.. "jdtls-workspace"
		.. package.config:sub(1, 1)
		.. project_name

	-- jvm performance improvement attemp -- -- -- --
	-- JVM arguments to improve performance
	local jvm_args = {
		"-Xms1G", -- Initial heap size (1GB)
		"-Xmx4G", -- Maximum heap size (4GB, adjust as needed)
		"-XX:+UseG1GC", -- Use the G1 Garbage Collector
		"-Dsun.zip.disableMemoryMapping=true", -- I/O performance tweak
		"-Dlog.level=WARN", -- Suppress noisy info/debug logs if necessary
	}
	-- end jvm performance improvement attemp -- -- -- --

	-- See `:help vim.lsp.start` for an overview of the supported `config` options.
	local config = {
		name = "jdtls",

		-- `cmd` defines the executable to launch eclipse.jdt.ls.
		-- `jdtls` must be available in $PATH and you must have Python3.9 for this to work.
		--
		-- As alternative you could also avoid the `jdtls` wrapper and launch
		-- eclipse.jdt.ls via the `java` executable
		-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
		cmd = {
			"jdtls",
			"-data",
			workspace_dir,
		},

		on_new_config = function(new_config)
			vim.list_extend(new_config.cmd, jvm_args)
		end,

		-- `root_dir` must point to the root of your project.
		-- See `:help vim.fs.root`
		root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw" }),

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {},
		},

		-- This sets the `initializationOptions` sent to the language server
		-- If you plan on using additional eclipse.jdt.ls plugins like java-debug
		-- you'll need to set the `bundles`
		--
		-- See https://codeberg.org/mfussenegger/nvim-jdtls#java-debug-installation
		--
		-- If you don't plan on any eclipse.jdt.ls plugins you can remove this
		init_options = {
			bundles = {},
		},
	}
	require("jdtls").start_or_attach(config)
end
-- ===============================================================================

M.mason_lsp_config = {
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
	{
		"mfussenegger/nvim-jdtls",
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = function()
					-- require("java.jdtls_config").setup() -- old way for multi file setup
					M.setup()
				end,
			})
		end,
	},
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
-- ===============================================================================

return M
