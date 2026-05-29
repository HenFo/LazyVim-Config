return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        auto_trigger = false,
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      -- Remove copilot from auto-triggered sources
      opts.sources = opts.sources or {}
      if type(opts.sources.default) == "table" then
        opts.sources.default = vim.tbl_filter(function(s)
          return s ~= "copilot"
        end, opts.sources.default)
      end
      -- Manually trigger Copilot completions via Alt-c
      opts.keymap = opts.keymap or {}
      opts.keymap["<M-c>"] = {
        function()
          local blink = require("blink.cmp")
          if blink.is_visible() then
            blink.hide()
          else
            blink.show({ providers = { "copilot" } })
          end
        end,
      }
      return opts
    end,
  },
}
