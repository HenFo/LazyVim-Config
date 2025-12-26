if not vim.g.vscode then
  return {}
end

-- Require the VSCode API module
local vscode = require("vscode")
local opts = { noremap = true, silent = true }

local mappings = {
  -- {mode, command, vscodeAction}
  { "n", "gD", "editor.action.revealDefinitionAside" },
  { "n", "gi", "editor.action.goToImplementation" },
  { "n", "gs", "workbench.action.gotoSymbol" },
  { "n", "gR", "editor.action.referenceSearch.trigger" },
  { "n", "gI", "editor.action.peekImplementation" },
  { "n", "gS", "workbench.action.showAllSymbols" },
  { "n", "<leader>rf", "editor.action.refactor" },
  { "n", "<leader>ff", "workbench.action.quickOpen" },
  { "n", "<leader>fif", "actions.find" },
  { "n", "<leader>fr", "editor.action.startFindReplaceAction" },
  { "n", "<leader>faf", "workbench.action.findInFiles" },
  { "n", "<leader>/", "workbench.action.findInFiles" },
  { "n", "<leader>qf", "editor.action.quickFix" },
  { "n", "<leader>ne", "editor.action.marker.next" },
  { "n", "<leader>Ne", "editor.action.marker.prev" },
  { "n", "<leader>rt", "workbench.action.tasks.runTask" },
  { "n", "<leader>ex", "workbench.files.action.showActiveFileInExplorer" },
  { "n", "<leader>bd", "workbench.action.closeActiveEditor" },
}

for _, mapping in ipairs(mappings) do
  local mode, command, action = mapping[1], mapping[2], mapping[3]
  vim.keymap.set(mode, command, function()
    vscode.call(action)
  end, opts)
end

-- Custom function to close all editors and show last file in explorer
vim.keymap.set("n", "<leader>bD", function()
  vscode.call("workbench.files.action.showActiveFileInExplorer")
  vim.defer_fn(function()
    vscode.call("workbench.action.closeAllEditors")
  end, 100)
end, { noremap = true, silent = true, desc = "Close all editors and show in explorer" })
