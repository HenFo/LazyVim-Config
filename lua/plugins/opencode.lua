local function save_current_buffer()
  if vim.bo.buftype == "" and vim.bo.modifiable and vim.bo.modified and vim.api.nvim_buf_get_name(0) ~= "" then
    vim.cmd.write()
  end
end

return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  init = function()
    vim.g.opencode_opts = {
      server = {
        -- Only connect to already-running opencode instances.
        start = false,
      },
      select = {
        server = false,
      },
    }

    vim.o.autoread = true
  end,
  keys = {
    {
      "<leader>aa",
      function()
        save_current_buffer()
        require("opencode").ask("@this: ")
      end,
      mode = "n",
      desc = "Ask About This",
    },
    {
      "<leader>aa",
      function()
        save_current_buffer()
        return require("opencode").operator("@this: ")
      end,
      mode = "x",
      expr = true,
      desc = "Ask About This",
    },
    {
      "<leader>as",
      function()
        save_current_buffer()
        require("opencode").select()
      end,
      mode = "n",
      desc = "Select Opencode Action",
    },
    {
      "<leader>as",
      function()
        save_current_buffer()
        require("opencode").select()
      end,
      mode = "x",
      desc = "Select Opencode Action",
    },
    {
      "<leader>af",
      function()
        save_current_buffer()
        require("opencode").prompt("Fix @diagnostics")
      end,
      mode = "n",
      desc = "Fix Diagnostics",
    },
    {
      "<leader>af",
      function()
        save_current_buffer()
        return require("opencode").operator("Fix @diagnostics")
      end,
      mode = "x",
      expr = true,
      desc = "Fix Diagnostics",
    },
  },
}
