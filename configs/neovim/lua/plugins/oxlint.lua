-- Oxlint: fast JavaScript/TypeScript linter (50-100x faster than ESLint)
-- Supports: js, mjs, cjs, jsx, ts, mts, cts, tsx
-- Partial support: vue, svelte, astro (script blocks only)
-- Install: npm i -D oxlint (or brew install oxc)
return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      javascript = { "oxlint" },
      typescript = { "oxlint" },
      javascriptreact = { "oxlint" },
      typescriptreact = { "oxlint" },
      vue = { "oxlint" },
      svelte = { "oxlint" },
      astro = { "oxlint" },
    },
  },
}
