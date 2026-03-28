return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false, -- Disable scrolling animations
    },
    keys = {
      -- disable key mapping
      { "<leader>n", false },
    },
    bigfile = {
      enabled = true, -- Disable big file support
      size = 4 * 1024 * 1024, -- Set the big file size threshold to 4MB
    },
  },
}
