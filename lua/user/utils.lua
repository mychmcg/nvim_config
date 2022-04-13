-- Utils for a better ide
local M = {}

-- Allows config to be reloaded without restarting nvim 
function M.reload_config()
  local count = 0
  for name,_ in pairs(package.loaded) do
    -- Which-Key needs to be unloaded separately for 
    -- whichkey to update(and work at all)
    if name:match('^which.*$') then
      package.loaded[name] = nil
      count = count + 1
    end

    -- Unload/uncache all user files
    if name:match('^user') then
      package.loaded[name] = nil
    end
    -- Which-Key needs to be unloaded separately for 
    -- whichkey to update(and work at all)
    --if name:match('^which') then
    --  package.loaded[name] = nil
    --end
  end
  
  dofile(vim.env.MYVIMRC)
  vim.cmd[[set background=light]]
end

function M.unload_whichkey()
  local count = 0
  for name,_ in pairs(package.loaded) do
    -- Which-Key needs to be unloaded separately for 
    -- whichkey to update(and work at all)
    if name:match('^which.*$') then
      package.loaded[name] = nil
      count = count + 1
    end
  end
  vim.cmd(string.format("echo 'Which-Key unloaded %s modules'",count))
  vim.api.nvim_set_keymap("", "<Space>", "<Nop>", {noremap = true, silent = true})  
end

function M.print_stuff()
  -- vim.cmd[[echo 'Hello There m8']]
  vim.cmd("edit didstuff")
end

return M
