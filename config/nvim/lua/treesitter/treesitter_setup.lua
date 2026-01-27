local M = {}

function M:setup()
	local treesitter = require("nvim-treesitter")
	require("nvim-treesitter.install").compilers = {
		"clang",
		"gcc",
		"cc",
		"cl",
	}

	local langs = {
		"c",
		"zig",
		"assembly",
		"fortran",
		"java",
		"python",
		"bash",
		-- "cpp",
		-- "c_sharp",
		-- "javascript",
		-- "html",
		-- "css",
		-- "kotlin",
		-- "cmake",
		"make",
		-- "php",
		"lua",
		-- "rust",
		-- "json",
		-- "go",
		"markdown",
		-- "csv",
		-- "diff",
		-- "dockerfile",
		-- "gitignore",
		-- "typescript",
		-- "yaml",
	}

	treesitter.install({
		langs,
		"markdown_inline",
	})

	vim.api.nvim_create_autocmd("FileType", {
		pattern = langs,
		callback = function()
			vim.treesitter.start()
		end,
	})
end

return M
