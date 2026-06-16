vim.loader.enable() -- Enable faster startup by caching compiled Lua modules

-- require 'options'		-- [[ Setting options ]]
require 'keymaps'		-- [[ Basic Keymaps ]]
require 'pack'			-- [[ Set up vim.pack ]]
require 'plugins'		-- [[ Configure and install plugins ]]
require 'auto_skip'


--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

--help files open in full window and are listed in buffer elements
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function()
		vim.cmd("only")
		vim.bo.buflisted = true
	end,
})

-- navigate dirs when a file wasn't specified
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- base
vim.opt.mouse = "" -- disable mouse
vim.opt.number = true
vim.wo.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true                     -- tab character will not show if this is on
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.foldenable = false
vim.opt.scrolloff = 10                          -- Minimal number of screen lines to keep above and below the cursor.

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
-- indent line aka ibl doe override the tab character
vim.opt.listchars = { tab = "│ ", trail = "·", nbsp = "␣" }

-- visual
-- vim.opt.colorcolumn = "yes"
vim.opt.colorcolumn = "82"
vim.opt.signcolumn = "yes"                      -- Keep signcolumn on by default
-- vim.opt.showmatch = false -- makes auto indetn very slow when on    -- highlight matching brackets
vim.opt.termguicolors = true
vim.opt.cursorline = false                      -- Show which line your cursor is on

-- file
vim.opt.undofile = true                         -- save undo history
vim.opt.autoread = true                         -- auto reload file if changed from outside
vim.opt.autowrite = false                       -- auto save
vim.opt.updatetime = 250                        -- faster completion
vim.opt.timeoutlen = 300
vim.opt.confirm = true

vim.opt.signcolumn = "yes"

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.inccommand = "split"

-- options from kickstart
vim.o.showmode = false
vim.o.breakindent = true
vim.o.splitright = true
vim.o.splitbelow = true


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

require 'undo_tree'
