-- Some exception handling for colorscheme setting
-- I have no idea what the catch statement says
-- Stolen from lunarvim/neovim-from-scratch
function _G.SetColorScheme(cs, style)
  local style = string.format("lua vim.g.%s_style = %s", cs, style)
  vim.cmd(style)
  
  if (style == 'light') then
    vim.cmd[[set background=light]]
  end

  vim.cmd(string.format("try\
  colorscheme %s\
  catch /^Vim\\%%((\\a\\+)\\)\\=:E185/\
  colorscheme default\
  set background=dark\
  endtry", 
    cs)
  )
end



vim.g.neon_italic_keyword = true
vim.g.neon_italic_function = true

vim.cmd[[set background=dark]]
SetColorScheme('tokyonight', 'dark')
