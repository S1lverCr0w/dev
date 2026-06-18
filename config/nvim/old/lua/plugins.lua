-- Load plugin modules in order.

-- require 'plugins.guess-indent'
require 'plugins.onedark'
require 'plugins.indent_line'
require 'plugins.gitsigns'
require 'plugins.which-key'
require 'plugins.telescope'
require 'plugins.conform'
require 'plugins.blink'
require 'plugins.todo-comments'
require 'plugins.lspconfig'
require 'plugins.treesitter'

-- The following comments only work if you have downloaded the repo, not just copy pasted the
-- init.lua. If you want these files, they are in the repository, so you can just download them and
-- place them in the correct locations.

-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
--
--  Here are some example plugins that I've included in the repository.
--  Uncomment any of the lines below to enable them (you will need to restart nvim).
--
-- require 'plugins.debug'
-- require 'plugins.lint'
-- require 'plugins.autopairs'
-- require 'plugins.neo-tree'
-- require 'plugins.gitsigns' -- adds gitsigns recommended keymaps

-- NOTE: You can add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--
--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
-- require 'custom.plugins'
