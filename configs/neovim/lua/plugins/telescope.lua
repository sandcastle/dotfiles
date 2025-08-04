return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {},
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
      pickers = {
        find_files = {
          hidden = true,       -- show dotfiles like .env, .gitignore, etc
          no_ignore = true,    -- include files ignored by .gitignore
        },
        live_grep = {
          additional_args = function()
            return {"--hidden"}
          end
        },
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          mappings = {
            i = {
              ["<c-d>"] = "delete_buffer",
            }
          }
        },
      },
    })
  end,
}
