-- persist cursor line after closing
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.api.nvim_exec2("normal! g'\"", { output = false })
		end
	end,
})

-- stop nvim from adding comments on new lines after a comment
-- <C-u> removes comment in insert mode
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function() vim.hl.on_yank() end,
})

-- completion pop-up color change to maek it stand out from the bg -- maybe add to onedark setup??
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- -- main completion menu
		-- vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#0c0d10", fg = "#abb2bf" }) -- deep abyss
		-- vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#121317", fg = "#abb2bf" }) -- defined constrast
		vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#16181c", fg = "#abb2bf" }) -- subtle contrast
		-- vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#1f232a", fg = "#abb2bf" }) -- brighter/greyish

		-- Signature Help / Parameter hints popup (e.g., typing printf(" )
        vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { bg = "#16181c", fg = "#abb2bf" })
        -- vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = "#16181c", fg = "#2c313c" })

		-- -- menu Border
		-- vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "#1f232a", fg = "#4b5263" })

		-- -- the currently selected item in the list
		-- vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#2c313c" })
		-- vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#2c313c", fg = "#ffffff", bold = true })
	end,
})
