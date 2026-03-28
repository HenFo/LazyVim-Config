return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  init = function()
    vim.g.opencode_opts = {
      server = {
        -- Only connect to already-running opencode instances.
        start = false,
        stop = false,
        toggle = false,
      },
      select = {
        sections = {
          server = false,
        },
      },
    }

    vim.o.autoread = true
  end,
  keys = {
    {
      "<leader>aa",
      function()
        require("opencode").ask("@this: ", { submit = true })
      end,
      mode = { "n", "x" },
      desc = "Ask About This",
    },
    {
      "<leader>as",
      function()
        require("opencode").select()
      end,
      mode = { "n", "x" },
      desc = "Select Opencode Action",
    },
    {
      "<leader>af",
      function()
        require("opencode").prompt("fix")
      end,
      mode = { "n", "x" },
      desc = "Fix Diagnostics",
    },
  },
}
