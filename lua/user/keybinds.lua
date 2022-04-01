local wk = require('which-key')

local bind = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- Remap space as leader key
bind("","<space>","<nop>",opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.cmd([[command! Plugins edit $HOME/.config/nvim/lua/ext/plugins.lua]])

-- funcs
function _G.EditConfigFile(file)
  vim.cmd(string.format("edit $HOME/.config/nvim/lua/user/%s.lua", file))
end

wk.register({
  b = {
    name = "buffer",
    d = {":bd<cr>", "Buffer Delete"},
    n = {":bn<cr>", "Buffer Next"},
    p = {":bp<cr>", "Buffer Previous"},
    w = {":w<cr>",  "Buffer Write"},
  },
  e = {
    name = "edit",
    c = {
      name = "config",
      o = {"<cmd>lua EditConfigFile('options')<cr>",  "Edit Config Options"},
      k = {"<cmd>lua EditConfigFile('keybinds')<cr>", "Edit Config Keybinds"},
      p = {"<cmd>lua EditConfigFile('plugins')<cr>",  "Edit Config Plugins"},
    },
    n = {":edit ", "Edit New"},
    --n = {"<cmd>edit $HOME/.config/nvim/lua/ext/plugins.lua<CR>",  "Edit Plugins"},
    o = {"<cmd>lua EditConfigFile('options')<cr>", "Edit Options"},
    p = {":Plugins<cr>",  "Edit Plugins"},
  },
  w = {
    name = "write",
    q = {":wq<cr>", "Write Quit"},
    w = {":w<cr>",  "Write"},
  },
}, {prefix = "<leader>"})

