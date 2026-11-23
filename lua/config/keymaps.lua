-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

require("config.vscode_keymapps")

local function format_with_prettier()
  require("conform").format({
    async = true,
    formatters = { "prettier_manual" },
    lsp_format = "last",
  })
end

vim.keymap.set("n", "<leader>o", "mzo<Esc>`z", { desc = "Insert space below" })
vim.keymap.set("n", "<leader>O", "mzO<Esc>`z", { desc = "Insert space above" })
vim.keymap.set({ "n", "x" }, "<leader>h", "^", { desc = "Jump to line end" })
vim.keymap.set({ "n", "x" }, "<leader>l", "g_", { desc = "Jump to line start" })

vim.keymap.del("n", "<leader>n")

if not vim.g.vscode then
  vim.keymap.set("n", "<leader>cP", format_with_prettier, { desc = "Format with Prettier" })

  vim.keymap.set("n", "<leader><space>", function()
    Snacks.picker.files({
      hidden = true,
      follow = true,
    })
  end, { desc = "Find Files (Root Dir)" })

  vim.keymap.set("n", "<leader>fi", function()
    Snacks.picker.files({
      hidden = true,
      ignored = true,
      follow = true,
    })
  end, { desc = "Find Files (include gitignored)" })

  vim.keymap.set("n", "<leader>f/", function()
    Snacks.picker.resume()
  end, { desc = "Resume Last Picker" })

  vim.keymap.set("n", "<leader>Nq", vim.cmd.cprev, { desc = "Previous Quickfix" })
  vim.keymap.set("n", "<leader>nq", vim.cmd.cnext, { desc = "Next Quickfix" })

  vim.keymap.set("n", "<leader>ng", "]h", { remap = true, desc = "Next Git Hunk" })
  vim.keymap.set("n", "<leader>Ng", "[h", { remap = true, desc = "Previous Git Hunk" })

  vim.keymap.set("n", "<leader>gH", function()
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then
      vim.notify("Current buffer has no file", vim.log.levels.WARN)
      return
    end

    Snacks.picker.git_diff({
      cwd = vim.fn.fnamemodify(file, ":h"),
      finder = function(opts, ctx)
        local finder = require("snacks.picker.source.git").diff(opts, ctx)
        return function(cb)
          finder(function(item)
            if Snacks.picker.util.path(item) == vim.fs.normalize(file) then
              cb(item)
            end
          end)
        end
      end,
    })
  end, { desc = "Git Diff (current buffer hunks)" })

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
