-- undo_tree
vim.cmd('packadd nvim.undotree')
vim.keymap.set('n', '<leader>u', '<cmd>Undotree<cr>', { desc = 'Undotree: panel show/hide' })

-- -- Load and open the built-in Undotree with layout adjustments
-- vim.keymap.set("n", "<leader>u", function()
-- 	-- Safely load the package if it isn't already active
-- 	pcall(vim.cmd, "packadd nvim.undotree")
--
-- 	-- Configure layout options and open the tree
-- 	require("undotree").open({
-- 		position = "left",      -- "left" or "right" side of the editor
-- 		layout = "left_bottom",  -- Layout split: "left_bottom" or "left_left_bottom"
-- 		window = {
-- 			width = 0.30,        -- Set width (30% of total editor width)
-- 			height = 0.25,       -- Set preview window height (25% of editor height)
-- 			border = "rounded",  -- Border style for floating diff windows
-- 		},
-- 		float_diff = false,      -- Set to true if you want the diff in a floating window
-- 	})
-- end, { desc = "Toggle Undo Tree (Custom Layout)" })
