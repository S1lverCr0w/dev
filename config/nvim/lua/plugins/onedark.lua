local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'S1lverCr0w/edpt-dark.nvim' }

vim.cmd.colorscheme 'onedark'
