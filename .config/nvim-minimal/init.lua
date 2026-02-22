-- =============================================================================
-- Minimal Neovim Configuration Bootstrap
-- This is the entry point - it loads the modular configuration
-- =============================================================================

-- -----------------------------------------------------------------------------
-- Leader Key Setup
-- Must be set before loading plugins
-- -----------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- -----------------------------------------------------------------------------
-- Set cleaner titles
vim.opt.title = true
vim.opt.titlestring = '%t'
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Bootstrap lazy.nvim Plugin Manager
-- Automatically install if not present
-- -----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- -----------------------------------------------------------------------------
-- Load Core Configuration
-- Options, keymaps, and autocommands
-- -----------------------------------------------------------------------------
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- -----------------------------------------------------------------------------
-- Setup Plugins with lazy.nvim
-- Plugins are organized in lua/plugins/
-- -----------------------------------------------------------------------------
require("lazy").setup({
  { import = "plugins.ui" },
  { import = "plugins.editor" },
  { import = "plugins.lsp" },
}, {
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- -----------------------------------------------------------------------------
-- Load Custom Utilities
-- Statusline and external integrations
-- -----------------------------------------------------------------------------
require("utils.statusline").setup()
require("utils.integrations").setup()
