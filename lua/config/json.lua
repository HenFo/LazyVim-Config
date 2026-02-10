-- Treat JSON files as JSONC (comments allowed)
vim.filetype.add({
  pattern = {
    [".*%.json"] = "jsonc",
  },
})

require("lspconfig").jsonls.setup({
  filetypes = { "json", "jsonc" },
  init_options = { provideFormatter = true },
})
