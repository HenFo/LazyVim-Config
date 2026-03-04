vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function(args)
    vim.bo[args.buf].filetype = "jsonc"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "jsonc",
  callback = function()
    vim.opt_local.commentstring = "// %s"
  end,
})
