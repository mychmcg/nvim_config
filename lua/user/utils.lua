-- Utils for a better ide
local M = {}

-- Allows config to be reloaded without restarting nvim 
function M.reload_config()
  for name,_ in pairs(package.loaded) do
    if name:match('^user') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
end

return M
