local wk = require('which-key')

vim.cmd([[let mapleader = "<Space>"]])
vim.cmd([[command! Plugins edit $HOME/.config/nvim/lua/ext/plugins.lua]])

-- TODO Figure out why which-key binds are hanging and doing nothing
-- i think the getchar() function is looping/waiting for input indefinitely
wk.register({
  e = {
    name = "edit",
    --n = {"<cmd>edit ", "Edit New"},
    n = {"<Cmd>edit $HOME/.config/nvim/lua/ext/plugins.lua<CR>",  "Edit Plugins"},
    o = {"<cmd>edit $HOME/.config/nvim/lua/user/options.lua<cr>", "Edit Options"},
    p = {":Plugins<CR>",  "Edit Plugins"},
  },
}, {prefix = "<leader>"})

local bind = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
bind("n", "<Space>vp", ":Plugins <CR>", opts)
bind("n", "<Space>t", ":ToggleTerm <CR>", opts)
