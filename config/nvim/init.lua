vim.loader.enable()					-- enable faster startup by caching compiled lua modules

-- leader key -- must happen before plugins are laoded (or wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- fonts
vim.g.have_nerd_font = false		-- set to true if you have nerd font installed and selected in the terminal

-- base
vim.opt.mouse = ""					-- disable mouse
vim.opt.number = true				-- line numbers
vim.wo.relativenumber = true		-- relative line numbers
vim.opt.tabstop = 4					-- 
vim.opt.softtabstop = 4				-- 
vim.opt.shiftwidth = 4				-- 
-- vim.opt.expandtab = true			-- tab character will not show if this is on
vim.opt.autoindent = true			-- enable auto indent
vim.opt.smartindent = true			-- enable smart indent
vim.opt.wrap = false				-- disable soft wrap
vim.opt.foldenable = false			-- 
vim.opt.scrolloff = 12				-- min number of lines to keep at top/bottom of screen

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
-- vim.opt.showmatch = false					-- makes auto indent very slow when on    -- highlight matching brackets
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

-- -- options from kickstart
-- vim.o.showmode = false
-- vim.o.breakindent = true
-- vim.o.splitright = true
-- vim.o.splitbelow = true

-- require files -- for modular setup
require 'plugins'								-- enable plugins in this file but declaring the path to it
require 'keymaps'								-- custom mappings
require 'options'								-- custom options -- yank highlight / no auto comment on new line / open with cursor on same line as closing
require 'undo_tree'								-- enables undotree -- native plugin for non linear undo history
require 'auto_skip'								-- skip brackets/quotes -- minimal
