return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      filters = {
        dotfiles = false,      -- ✅ show dotfiles
        git_ignored = false,   -- ✅ also show .gitignored files
      },
      view = {
        width = 30,
        side = "left"
      },
      renderer = {
        group_empty = true,
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
    })
  end,
}
