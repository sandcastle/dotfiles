-- Use snacks.explorer instead of nvim-tree (built into snacks.nvim, zero extra deps)
-- Toggle with <leader>e (LazyVim default)
return {
  -- Disable nvim-tree (replaced by snacks.explorer)
  { "nvim-tree/nvim-tree.lua", enabled = false },

  -- Enable snacks explorer
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {},
    },
  },
}
