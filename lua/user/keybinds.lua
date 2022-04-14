local wk = require('which-key')

local bind = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- Remap space as leader key
-- bind("","<space>","<nop>",opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- funcs
function _G.EditConfigFile(file, subdir)
  subdir = subdir or 'user'
  vim.cmd(string.format("edit %s/lua/%s/%s.lua", _G.configpath, subdir, file))
end

function AdjustFontSize(amount)
  _G.fontsize = _G.fontsize + amount
  if (vim.fn.exists(':GuiFont') == 2) then
    vim.cmd(string.format("execute 'GuiFont! CaskaydiaCove NF:h%s'",_G.fontsize))
  else
    vim.cmd[[echo 'Terminal AdjustFontSize() not implemented']]
  end
end

local mappings = {
  b = {
    name = "buffer",
    d = {":bd<cr>", "Buffer Delete"},
    n = {":bn<cr>", "Buffer Next"},
    p = {":bp<cr>", "Buffer Previous"},
    w = {":w<cr>",  "Buffer Write"},
  },
  c = {
    name = "code",
    g = {":echo 'LSP not implemented'<cr>",  "Code Goto"},
  },
  e = {
    name = "edit",
    c = {
      name = "config",
      a = {"<cmd>lua EditConfigFile('autocommands')<cr>",   "Edit Config Autocommands"},
      c = {"<cmd>lua EditConfigFile('colorscheme')<cr>",    "Edit Config Colorscheme"},
      i = {"<cmd>lua vim.cmd(string.format('edit %s/init.lua', vim.fn.stdpath('config')))<cr>",  "Edit Config Index"},
      k = {"<cmd>lua EditConfigFile('keybinds')<cr>",       "Edit Config Keybinds"},
      o = {"<cmd>lua EditConfigFile('options')<cr>",        "Edit Config Options"},
      p = {"<cmd>lua EditConfigFile('plugins', 'ext')<cr>", "Edit Config Plugins"},
      t = {"<cmd>lua EditConfigFile('toggleterm')<cr>",     "Edit Config Toggleterm"},
      u = {"<cmd>lua EditConfigFile('utils')<cr>",          "Edit Config Utils"},
    },
    l = {"<cmd>lua vim.cmd(string.format('edit %s/nvim.log', vim.fn.stdpath('config')))<cr>",  "Edit startup Log"},
    n = {":edit ", "Edit New"},
  },
  n = {
    name = "navigate",
    c = {"<cmd>lua vim.cmd(string.format('cd %s', vim.fn.stdpath('config')))<cr>",  "Navigate to Config"},
    d = {"<cmd>cd ~/dev<cr>",  "Navigate to Dev"},
  },
  u = {
    name = "ui",
    f = {
      name = "font",
      ["+"] = {"<cmd>lua AdjustFontSize(1)<cr>",  "UI Font size +"},
      ["-"] = {"<cmd>lua AdjustFontSize(-1)<cr>", "UI Font size -"},
    },
    c = {
      name = "colorscheme",
      d = {":set background=dark<cr>",  "UI Colorscheme Dark"},
      l = {":set background=light<cr>", "UI Colorscheme Light"},
      n = {
        name = "neon",
        d = {"<cmd>lua SetColorScheme('neon', 'dark')<cr>",  "UI Colorscheme Neon Dark"},
        l = {"<cmd>lua SetColorScheme('neon', 'light')<cr>", "UI Colorscheme Neon Light"},
        o = {"<cmd>lua SetColorScheme('neon', 'doom')<cr>",  "UI Colorscheme Neon dOom"},
      },
      t = {
        name = "tokyonight",
        d = {"<cmd>lua SetColorScheme('tokyonight', 'dark')<cr>",  "UI Colorscheme Tokyonight Dark"},
        l = {"<cmd>lua SetColorScheme('tokyonight', 'light')<cr>", "UI Colorscheme Tokyonight Light"},
        s = {"<cmd>lua SetColorScheme('tokyonight', 'storm')<cr>", "UI Colorscheme Tokyonight Storm"},
      },
    },
    z = {":echo 'Zen Mode not implemented'<cr>",  "UI Zenmode"},
  },
  w = {
    name = "write",
    q = {":wq<cr>", "Write Quit"},
    w = {":w<cr>",  "Write"},
  },
}

-- lua vim.pretty_print(package.loaded["which-key.keys"].mappings.n.tree.root.children[" "].children)
mappings.i = {
    name = "inspect",
    w = {"<cmd>lua vim.pretty_print(package.loaded['which-key.keys'].mappings.n.tree.root.children[' '].children)<cr>",  "Inspect Which-key"},
}


wk.register(mappings, {prefix = "<leader>"})


