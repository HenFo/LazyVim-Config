return {
  {
    "stevearc/conform.nvim",
    opts = {
      -- Pick the formatter(s) for JSON
      formatters_by_ft = {
        json = { "jq" },
        jsonc = { "jq" },
      },
    },
  },
}
