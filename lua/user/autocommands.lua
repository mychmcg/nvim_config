-- Autocommands for various events

local api = vim.api 

-- helpers

-- toggles a flag based on modified state
-- only meant to be called during a BufWritePre event
-- used in conjunction with ModBufWritePost allows a function to be run only if the buffer was modified before writing
function _G.SetModBufWritePre()
  if (vim.bo.modified) then
    vim.b.ModBufWritePre = 1
  else
    vim.b.ModBufWritePre = 0
  end
end

-- calls function argument if buffer was modified and then written 
-- toggles off custom modified flag as the buffer is written now
-- only works if SetModBufWritePre was called during the BufWritePre event
function _G.ModBufWritePost(func)
  if (vim.b.ModBufWritePre > 0) then
    func()
    SetModBufWritePre() 
  end
end

-- Autocommands
local autocmds = {
  packer_user_config = {
    -- Autocommands that sync packer if plugins.lua is changed
    { "BufWritePre", "plugins.lua", "lua SetModBufWritePre()" };
    { "BufWritePost", "plugins.lua", "lua ModBufWritePost(function() vim.api.nvim_command('source <afile> | PackerSync') end)" };
  };
  reload_nvim_config = {
    -- Autocommands that reloads config if it is changed
    { "BufWritePre", "$MYVIMRC,$HOME/.config/nvim/lua/user/*.lua", "lua SetModBufWritePre()" };
    { "BufWritePost", "$MYVIMRC,$HOME/.config/nvim/lua/user/*.lua", "lua ModBufWritePost(function() require('user.utils').reload_config() end)" };
  };
}

local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup '..group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      api.nvim_command(command)
    end
      api.nvim_command('augroup END')
    end
end

nvim_create_augroups(autocmds)
-- Autocommands END
