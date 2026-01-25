require("config.lazy")
require("keymaps")
-- require("java.jdtls_cmd") -- java jdtls eclipese lsp

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- sync clipboard with system clipboard
-- vim.opt.clipboard = 'unnamedplus'

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

-- persist cursor line after closing
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.api.nvim_exec("normal! g'\"", false)
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

-- --keymap
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
--
-- --unhighlight
-- vim.keymap.set("n", "<leader>h", ":noh<CR>", { silent = true })
--
-- --terminal
-- vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])
--
-- --saving&quitting
-- vim.keymap.set("n", "<C-s>", ":w<CR>")
-- vim.keymap.set("n", "<F5>", ":wa<CR>")
-- vim.keymap.set("n", "<BS>", ":confirm bdelete<CR>")
-- vim.keymap.set("n", "<C-BS>", ":qa<CR>")
--
-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>f', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>b', builtin.buffers, {})

local treesitter = require("treesitter.treesitter_setup")
treesitter.setup()
