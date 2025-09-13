-- lua/plugins/example.lua
return {
  -- add a plugin
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = { enable = true },
      }
    end,
  },

  -- override options for a plugin managed by LazyVim (example: lualine)
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "tokyonight",
      },
    },
  },
}

