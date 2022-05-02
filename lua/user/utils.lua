-- Utils for a better ide
local M = {}

-- Allows config to be reloaded without restarting nvim 
function M.reload_config()
  for name,_ in pairs(package.loaded) do
    -- Which-Key needs to be unloaded separately for 
    -- whichkey to update(and work at all)
    if name:match('^which.*$') then
      package.loaded[name] = nil
    end

    -- Unload/uncache all user files
    if name:match('^user') then
      package.loaded[name] = nil
    end
  end
  
  -- Save font & fontsize
  local fs = _G.fontsize
  local font = vim.o.guifont
  dofile(vim.env.MYVIMRC)
  -- Restore font & fontsize
  _G.fontsize = fs
  vim.o.guifont = font
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
