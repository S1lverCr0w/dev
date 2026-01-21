require("config.lazy")
require("keymaps")

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
-- sync clipboard with system clipboard
-- vim.opt.clipboard = 'unnamedplus'

--help files open in full window and are listed in buffer elements
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.cmd("only")
        vim.bo.buflisted = true
    end
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.signcolumn = 'yes'
vim.o.foldenable = false
vim.o.wrap = false
vim.wo.relativenumber = true
vim.o.number = true

-- save undo history
vim.o.undofile = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Show which line your cursor is on
vim.o.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.inccommand = "split"

vim.opt.confirm = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "·", nbsp = "␣" }

-- persist cursor line after closing
vim.api.nvim_create_autocmd({"BufReadPost"}, {
    pattern = {"*"},
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
-- --telescope
-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>f', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>b', builtin.buffers, {})

local treesitter = require('treesitter.treesitter_setup')
treesitter.setup()
