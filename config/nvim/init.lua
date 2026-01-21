require("config.lazy")

vim.opt.termguicolors = true
-- sync clipboard with system clipboard
vim.opt.clipboard = 'unnamedplus'

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

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = true
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

--KEYMAPS
-- vim.keymap.set("n", "<Tab>", function()
--     require("oil").open()
-- end)

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

--unhighlight
vim.keymap.set("n", "<leader>h", ":noh<CR>", { silent = true })

--terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

--saving&quitting
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<F5>", ":wa<CR>")
vim.keymap.set("n", "<BS>", ":confirm bdelete<CR>")
vim.keymap.set("n", "<C-BS>", ":qa<CR>")

--copilot
--this is necessary to still allow default tab behavior when copilot suggestion is not visible
-- vim.keymap.set("i", "<Tab>", function()
--         local copilot = require("copilot.suggestion")
--         if copilot.is_visible() then
--             copilot.accept_line()
--         else
--             return "\t"
--         end
--     end,
--     { expr = true }
-- )
vim.keymap.set({ "n", "v" }, "`", ":CopilotChat<CR>")
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "copilot-chat",
    callback = function()
        vim.cmd("wincmd r")
    end,
})

--telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})

-- --harpoon --
-- local harpoon = require("harpoon")
-- harpoon:setup()
--
-- vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
--
-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
--
-- vim.keymap.set("n", "<C-,>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<C-.>", function() harpoon:list():next() end)
--
local treesitter = require('treesitter.treesitter_setup')
treesitter.setup()
