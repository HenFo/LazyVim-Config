return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      opts.formatters = opts.formatters or {}
      opts.formatters.prettier_manual = {
        inherit = false,
        command = require("conform.util").from_node_modules("prettier"),
        args = { "--stdin-filepath", "$FILENAME" },
        range_args = function(_, ctx)
          local start_offset, end_offset = require("conform.util").get_offsets_from_range(ctx.buf, ctx.range)
          return {
            "--stdin-filepath",
            "$FILENAME",
            "--range-start=" .. start_offset,
            "--range-end=" .. end_offset,
          }
        end,
        cwd = require("conform.formatters.prettierd").cwd,
      }
    end,
  },
}
