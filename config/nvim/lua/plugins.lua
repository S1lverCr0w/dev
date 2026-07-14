local function load(plugin) require('plugins.' .. plugin) end
-- local function load(plugin)
-- 	require('plugins.' .. plugin)
-- end

-- plugin list -- require plugin file to enable
-- load 'onedark'				-- ondearkpro theme -- custom
load 'edpt'				-- ondeark but darker theme -- custom from scratch
load 'indent_line'			-- indentation guides on blank lines
load 'gitsigns'				-- git diffs
load 'which_key'			-- key maps
load 'telescope'			-- fuzzy search
load 'conform'				-- formatter [leader f] or autoformat otions
load 'blink'				-- snippet engine --
load 'todo_comments'		-- highlight todo, notes, etc in comments
load 'treesitter'			-- used to highlight, edit and navigate code
load 'lspconfig'			-- lsp config




-- different way to load plugins -- by different i mean it looks less aesthetic
-- -- local function path_d(plugin) return 'plugins.' .. plugin end
-- local function path_d(plugin)
-- 	return 'plugins.' .. plugin
-- end
--
-- -- plugin list -- require plugin file to enable
-- require (path_d 'onedark')
