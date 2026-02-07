-- Lualine customizations (LazyVim already configures lualine with a rich setup)
-- Only override specific options here; don't replace the full config
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "tokyonight",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
  },
}
