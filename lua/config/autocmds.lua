-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--

require("config.json-as-jsonc")

local close_neotree_group = vim.api.nvim_create_augroup("close_neotree_on_file_enter", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = close_neotree_group,
  callback = function(args)
    local buf = args.buf
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end

    local filetype = vim.bo[buf].filetype
    local buftype = vim.bo[buf].buftype
    if filetype == "neo-tree" or buftype ~= "" then
      return
    end

    local ok, neotree = pcall(require, "neo-tree.command")
    if ok then
      neotree.execute({ action = "close" })
    end
  end,
})
