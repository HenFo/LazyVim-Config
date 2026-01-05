-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("config.vscode_keymapps")

vim.keymap.set("n", "<leader>o", "mzo<Esc>`z", { desc = "Insert space below" })
vim.keymap.set("n", "<leader>O", "mzO<Esc>`z", { desc = "Insert space above" })
vim.keymap.set({ "n", "x" }, "<leader>h", "^", { desc = "Jump to line end" })
vim.keymap.set({ "n", "x" }, "<leader>l", "g_", { desc = "Jump to line start" })

vim.keymap.del("n", "<leader>n")

if not vim.g.vscode then
  vim.keymap.set("n", "<leader>Nq", vim.cmd.cprev, { desc = "Previous Quickfix" })
  vim.keymap.set("n", "<leader>nq", vim.cmd.cnext, { desc = "Next Quickfix" })

  -- diagnostic
  local diagnostic_goto = function(next, severity)
    return function()
      vim.diagnostic.jump({
        count = (next and 1 or -1) * vim.v.count1,
        severity = severity and vim.diagnostic.severity[severity] or nil,
        float = true,
      })
    end
  end
  vim.keymap.set("n", "<leader>nd", diagnostic_goto(true), { desc = "Next Diagnostic" })
  vim.keymap.set("n", "<leader>Nd", diagnostic_goto(false), { desc = "Prev Diagnostic" })
  vim.keymap.set("n", "<leader>ne", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
  vim.keymap.set("n", "<leader>Ne", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
  vim.keymap.set("n", "<leader>nw", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
  vim.keymap.set("n", "<leader>Nw", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
end

-- disable s key so that it doesn't initiate insert mode
vim.keymap.set({ "n", "x" }, "s", "<Nop>")
-- activate surround with capital S in visual mode
vim.keymap.set(
  "x",
  "S",
  [[:<C-u>lua MiniSurround.add('visual')<CR>]],
  { silent = true, desc = "Start add surrounding to selection" }
)
