return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
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
			"make",
			"lua",
			"markdown",
			"markdown_inline",
			"vim",
			"vimdoc",
			"luadoc",
			"diff",
			-- "cpp", "c_sharp", "javascript", "html", "css", "kotlin", "cmake", "php", "rust", "json", "go", "csv", "diff", "dockerfile", "gitignore", -- causes an error "typescript", "yaml",
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
