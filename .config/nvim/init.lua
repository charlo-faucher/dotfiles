-- init.lua (dotfiles/nvim/.config/nvim/init.lua)

-- 1) bootstrap lazy.nvim (if missing)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- use 'stable' branch
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2) load your core config (options, keymaps, autocmds) early
-- create these files in lua/core/
pcall(require, "core")

-- 3) start lazy with LazyVim and your custom plugins
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" }, -- LazyVim distribution
    { import = "plugins" },                            -- your plugin specs in lua/plugins
  },
  defaults = { lazy = true, version = false },
  install = { colorscheme = { "tokyonight", "habamax" } }, -- optional
  checker = { enabled = true },
})

