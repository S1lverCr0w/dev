vim.api.nvim_create_user_command("OneDarkProDarkify", function()
	-- Fix the slash and expand the tilde to an absolute path
	-- local raw_path = "~/.local/share/nvim/site/pack/core/opt/onedark.nvim/lua/onedarkpro/highlights/syntax.lua"
	local raw_path = "~/.local/share/nvim/site/pack/core/opt/onedark.nvim/lua/onedarkpro/highlights/plugins/treesitter.lua"
	local target_file = vim.fn.expand(raw_path)

	-- Read the theme file from disk
	local file = io.open(target_file, "r")
	if not file then
		vim.notify("Failed to open file: " .. target_file, vim.log.levels.ERROR)
		return
	end
	local content = file:read("*all")
	file:close()

	-- Define list of search and replace patterns
	local replacements = {
		-- {
		-- 	find = "Constant = { fg = theme%.palette%.orange,",
		-- 	replace = "Constant = { fg = theme.palette.cyan,",
		-- },
		{
			find = '%["@string%.escape"%] = { fg = theme%.palette%.cyan,',
			replace = '["@string.escape"] = { fg = theme.palette.red,',
		},
		{
			find = '%["@punctuation%.bracket"%] = { fg = theme%.palette%.purple',
			replace = '["@punctuation.bracket"] = { fg = theme.palette.grey,',
		},
	}

	-- Loop through the list and apply each replacement
	local total_replacements = 0
	local updated_content = content

	for _, pair in ipairs(replacements) do
		local next_content, count = string.gsub(updated_content, pair.find, pair.replace)
		updated_content = next_content
		total_replacements = total_replacements + count
	end

	vim.cmd.OneDarkProClean()
	vim.cmd.OneDarkProCache()
	-- Write the file back only if something actually changed
	if total_replacements == 0 then
		vim.notify("No patterns matched. No changes made to testing file.", vim.log.levels.WARN)
		return
	end

	file = io.open(target_file, "w")
	if not file then
		vim.notify("Failed to write to file: " .. target_file, vim.log.levels.ERROR)
		return
	end
	file:write(updated_content)
	file:close()

	vim.notify(string.format("Success! Made %d change(s) in test file.", total_replacements), vim.log.levels.INFO)

	-- -- clear cache and relaod theme
	-- vim.cmd.OneDarkProClean()
	-- vim.cmd.OneDarkProCache()
	vim.cmd("colorscheme onedark")
	vim.notify("Theme reloaded instantly!", vim.log.levels.INFO)
end, {
	desc = "Apply multiple color replacements (Test Path)",
})
