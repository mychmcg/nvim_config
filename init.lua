require "user.options"
require "user.utils"
require "user.autocommands"
require "ext.plugins"
require "user.colorscheme"
require "user.keybinds"
require "user.toggleterm"

-- commands that reload neovim config
vim.cmd('command! ReloadConfig lua require("user.utils").reload_config()')
vim.cmd('command! UnloadWhichkey lua require("user.utils").unload_whichkey()')

