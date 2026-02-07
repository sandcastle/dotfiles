-- Mise integration: ensures mise-managed tools (LSPs, linters, formatters)
-- are available on PATH when Neovim starts.
-- This prepends mise shims so tools like oxlint, oxfmt, node, etc. resolve
-- to the correct project-specific versions managed by mise.
return {
  {
    "folke/snacks.nvim",
    opts = function()
      -- Prepend mise shims to PATH (must run early, before LSP/linters start)
      local shims = vim.env.HOME .. "/.local/share/mise/shims"
      if vim.fn.isdirectory(shims) == 1 and not vim.env.PATH:find(shims, 1, true) then
        vim.env.PATH = shims .. ":" .. vim.env.PATH
      end
    end,
  },
}
