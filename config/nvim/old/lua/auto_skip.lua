-- this skips over the closing brackets/quotes in insert mode while typing
local keys = {
	[")"] = ")",
	["]"] = "]",
	["}"] = "}",
	[">"] = ">",
	['"'] = '"',
	["'"] = "'",
	["`"] = "`",
	[";"] = ";",
	[":"] = ":",
	-- [" "] = " ", -- skip spaces
}

local filetypes = { -- apply only to these filestypes
	"c",
	"zig",
	"java",
	"fortran",
	"make",
	"python",
	"lua",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = filetypes,

	callback = function()
		for key, char in pairs(keys) do
			vim.keymap.set("i", key, function()
				-- _ is a throwaway variable as we only need the column where the cursor is (_ represents the row)
				local _, col = unpack(vim.api.nvim_win_get_cursor(0))
				local line = vim.api.nvim_get_current_line()
				local next_char = line:sub(col + 1, col + 1)

				if next_char == char then
					return "<Right>" -- move the cursor to the right one char
				end
				return key
			end, { expr = true, buffer = true }) -- expr turns <Right> to expresion from string, buffer applies the command only to current buffer
		end
	end,
})
