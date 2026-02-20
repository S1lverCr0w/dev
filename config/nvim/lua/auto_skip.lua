-- this skips over the closing brackets/quotes in insert mode while typing
local keys = {
	[")"] = ")",
	["]"] = "]",
	["}"] = "}",
	[">"] = ">",
	['"'] = '"',
	["'"] = "'",
	-- [" "] = " ", -- skip spaces
}

for key, char in pairs(keys) do
	vim.keymap.set("i", key, function()
		local col = vim.api.nvim_win_get_cursor(0)[2]
		local line = vim.api.nvim_get_current_line()
		local next_char = line:sub(col + 1, col + 1)

		if next_char == char then
			return "<Right>" -- move the cursor to the right one char
		end
		return key
	end, { expr = true })
end
