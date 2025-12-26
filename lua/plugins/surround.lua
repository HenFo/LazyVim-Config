return {
  "nvim-mini/mini.surround",
  opts = {
    highlight_duration = 5000,
    mappings = {
      add = "sa", -- Add surrounding in Normal and Visual modes
      delete = "sd", -- Delete surrounding
      replace = "sr", -- Replace surrounding
    },
  },
}
