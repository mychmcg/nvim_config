local fn = vim.fn


-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}



-- Plugin declarations
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Colorschemes
  use "folke/tokyonight.nvim" 
  use "lunarvim/colorschemes"
  use "rafamadriz/neon"

  -- plenary is a dependency of which-key.reset() & neorg, 
  use "nvim-lua/plenary.nvim"
  use { 
    "nvim-treesitter/nvim-treesitter",
    before = "neorg",
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "norg", "c", "lua", "rust" },
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  }
  use {
    "nvim-neorg/neorg",
    config = function()
        require('neorg').setup {
          load = {
            ["core.defaults"] = {},
            ["core.integrations.treesitter"] = {
              config = {

                norg      = {
                  url = "https://github.com/nvim-neorg/tree-sitter-norg",
                  files = { "src/parser.c", "src/scanner.cc" },
                  branch = "main"
                },
                norg_meta = {
                  url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
                  files = { "src/parser.c" },
                  branch = "main"
                },
                norg_table = {
                  url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
                  files = { "src/parser.c" },
                  branch = "main"
                }
              
              }
            },
            ["core.norg.concealer"] = {},
          }
        }
    end,
    requires = "nvim-lua/plenary.nvim",
    tag = "*"
  }
  use "folke/which-key.nvim" 
  use {"akinsho/toggleterm.nvim", branch = "main"}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)


