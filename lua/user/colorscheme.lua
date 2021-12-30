-- Some exception handling for colorscheme setting
-- I have no idea what the catch statement says
-- Stolen from lunarvim/neovim-from-scratch
vim.cmd [[
try
  colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
