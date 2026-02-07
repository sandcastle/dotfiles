-- Which-key customizations (LazyVim already configures which-key)
-- Only add custom group labels here; don't override the full setup
return {
  "folke/which-key.nvim",
  opts = {
    preset = "modern",
    delay = 500,
    win = {
      border = "rounded",
      padding = { 1, 2 },
    },
  },
}
