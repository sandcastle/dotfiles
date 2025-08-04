return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "modern",
      delay = 500,
      plugins = {
        marks = true,
        registers = true,
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
      },
    })

    -- Define key groups for better organization
    wk.add({
      { "<leader>f", group = "Find/Search" },
      { "<leader>g", group = "Git" },
      { "<leader>s", group = "Split/Search" },
      { "<leader>t", group = "Tabs" },
      { "<leader>e", group = "Explorer" },
      { "<leader>n", group = "Navigation/Numbers" },
    })
  end,
}
