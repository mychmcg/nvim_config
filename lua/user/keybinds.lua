local wk = require('which-key')

local bind = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

-- Remap space as leader key
-- bind("","<space>","<nop>",opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- funcs
function _G.UnimplementedFeatureMsg(msg)
  vim.cmd(string.format("echo '%s is an unimplemented feature.'", msg))
end

function _G.EditFile(file)
  vim.cmd(string.format("edit %s", file))
end

function _G.EditConfigFile(file, subdir)
  -- subdir is an optional arg, defaults to user dir
  subdir = subdir or 'user'
  local fn = string.format("%s/lua/%s/%s.lua", _G.configpath, subdir, file)
  EditFile(fn)
end

function _G.EditFileCwd()
  local cwd = string.format("%s/",vim.fn.getcwd())
  local fn = vim.fn.input("Filename: ", cwd, "dir")
  EditFile(fn)
end

function _G.EditNote(file, subdir)
  subdir = subdir or ''
  if (subdir~='') then
    subdir = string.format('%s/',subdir)
  end
  local parent = string.format('%s/%s', _G.notespath, subdir)
  local path = string.format('%s%s.norg', parent, file)
  vim.fn.mkdir(parent, 'p')
  vim.cmd(string.format('cd %s', parent))
  EditFile(path)
end

function _G.EditNewDailyNote()
  local parent = string.format('todo/daily/%s', home, os.date('%Y/%m'))
  local fn = os.date('%a_%m_%d_%Y.norg')
  local path = string.format('%s/%s', parent, fn)
  
  vim.fn.mkdir(parent, 'p')
  vim.cmd(string.format('cd %s', parent))
  EditFile(path)
  vim.cmd[[Neorg inject-metadata]]
  vim.api.nvim_buf_set_lines(0, -1, -1, false, {"Hello World"})
end

function _G.AdjustFontSize(amount)
  _G.fontsize = _G.fontsize + amount
  if (vim.fn.exists(':GuiFont') == 2) then
    vim.cmd(string.format("execute 'GuiFont! CaskaydiaCove NF:h%s'",_G.fontsize))
  else
    -- _G.UnimplementedFeatureMsg('AdjustFontSize in terminal')
    -- all work in neovide
    vim.o.guifont, _ = string.gsub(vim.o.guifont, ":h.*", string.format(":h%s", _G.fontsize))
    -- vim.o.guifont = string.format("CaskaydiaCove NF:h%s",_G.fontsize)
    -- vim.cmd(string.format('set guifont=CaskaydiaCove\\ NF:h%s',_G.fontsize))
  end
end

function _G.MakeDirectoryFromUser()
  local cwd = string.format("%s/",vim.fn.getcwd())
  vim.fn.mkdir(vim.fn.input("Dirname: ", cwd, "dir"), 'p')
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
    -- TODO add popup window with list of files in cwd
    f = {":edit <tab>", "Edit File in cwd"},
    l = {"<cmd>lua vim.cmd(string.format('edit %s/nvim.log', vim.fn.stdpath('config')))<cr>",  "Edit startup Log"},

    n = {"<cmd>lua EditFileCwd()<cr>", "Edit New"},
    t = {
      name = "todo",
      i = {"<cmd>lua EditNote('todo/index')<cr>", "Edit Todo Index"},
      d = {
        name = "daily",
        p = {":echo 'Edit Previous Daily not implemented'<cr>", "Edit Todo Daily Previous"},
        n = {"<cmd>lua EditNewDailyNote()<cr>", "Edit Todo Daily New"},
      },
    },



  },
  m = {
    name = "make",
    -- TODO add popup window/prompt for names of new dirs/files

    d = {"<cmd>lua _G.MakeDirectoryFromUser()<cr>", "Make Dir"},



  },
  n = {
    name = "navigate",
    c = {"<cmd>lua vim.cmd(string.format('cd %s', vim.fn.stdpath('config')))<cr>",  "Navigate to Config"},
    d = {"<cmd>cd ~/dev<cr>",  "Navigate to Dev"},
    n = {"<cmd>cd ~/notes<cr>",  "Navigate to Notes"},
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


