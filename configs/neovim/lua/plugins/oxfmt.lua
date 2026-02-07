-- Oxfmt: Prettier-compatible formatter (~30x faster than Prettier)
-- Status: Alpha (~95% Prettier test suite compat)
-- Supports: js, jsx, ts, tsx, json, jsonc, json5, yaml, toml, html,
--           vue, css, scss, less, markdown, mdx, graphql, angular, handlebars
-- Install: npm i -D oxfmt (or brew install oxc)
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      javascript = { "oxfmt" },
      typescript = { "oxfmt" },
      javascriptreact = { "oxfmt" },
      typescriptreact = { "oxfmt" },
      json = { "oxfmt" },
      jsonc = { "oxfmt" },
      yaml = { "oxfmt" },
      toml = { "oxfmt" },
      html = { "oxfmt" },
      vue = { "oxfmt" },
      css = { "oxfmt" },
      scss = { "oxfmt" },
      less = { "oxfmt" },
      markdown = { "oxfmt" },
      graphql = { "oxfmt" },
      handlebars = { "oxfmt" },
      svelte = { "oxfmt" },
      astro = { "oxfmt" },
    },
    formatters = {
      oxfmt = {
        command = "oxfmt",
        args = { "--stdin-filepath", "$FILENAME" },
        stdin = true,
      },
    },
  },
}
