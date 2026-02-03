return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",

	config = function()
		local filetypes = {
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
			"markdown_inline",
			-- "csv",
			-- "diff",
			-- "dockerfile",
			-- "gitignore", -- causes an error
			-- "typescript",
			-- "yaml",
			"vim",
			"vimdoc",
			"luadoc",
			"diff",
		}
		require("nvim-treesitter.install").compilers = {
			"clang",
			"gcc",
			"cc",
			"cl",
		}
		require("nvim-treesitter").install(filetypes)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
