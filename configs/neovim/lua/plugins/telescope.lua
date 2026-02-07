-- Use snacks.picker instead of telescope (built into snacks.nvim, zero extra deps)
-- Provides: file finder, live grep, buffers, git, LSP symbols, and more
-- All LazyVim picker keybindings (<leader>ff, <leader>/, <leader>,, etc.) work automatically
return {
  -- Disable telescope (no longer needed)
  { "nvim-telescope/telescope.nvim", enabled = false },
  { "nvim-telescope/telescope-fzf-native.nvim", enabled = false },

  -- Enable snacks picker
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        -- Show hidden files in file finder
        sources = {
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
      },
    },
  },
}
