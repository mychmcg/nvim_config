-- Utils for a better ide
local M = {}

-- Allows config to be reloaded without restarting nvim 
function M.reload_config()
  for name,_ in pairs(package.loaded) do
    -- Unload/uncache all user files
    if name:match('^user') then
      package.loaded[name] = nil
    end
    -- Which-Key needs to be unloaded separately for 
    -- whichkey to update(and work at all)
    if name:match('^which-key') then
      require('which-key').reset()
    end
  end

  dofile(vim.env.MYVIMRC)
end

return M
