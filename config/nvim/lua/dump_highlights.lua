-- save as dump_highlights.lua, then :luafile dump_highlights.lua
local function dump()
  local groups = vim.api.nvim_get_hl(0, {})
  local names = vim.tbl_keys(groups)
  table.sort(names)

  local lines = {}
  for _, name in ipairs(names) do
    local hl = vim.api.nvim_get_hl(0, { name = name })
    if hl.link then
      table.insert(lines, name .. ' -> link ' .. hl.link)
    else
      table.insert(lines, name)
    end
  end

  local path = vim.fn.stdpath('data') .. '/all_highlights.txt'
  vim.fn.writefile(lines, path)
  print('dumped ' .. #lines .. ' groups to ' .. path)
end

dump()
