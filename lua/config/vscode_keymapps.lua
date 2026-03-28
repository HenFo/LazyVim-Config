if not vim.g.vscode then
  return {}
end

-- Require the VSCode API module
local vscode = require("vscode")
local opts = { noremap = true, silent = true }

local mappings = {
  -- {mode, command, vscodeAction}
  { "n", "gd", "editor.action.revealDefinition" },
  { "n", "gr", "editor.action.referenceSearch.trigger" },
  { "n", "gi", "editor.action.goToImplementation" },
  { "n", "gy", "editor.action.goToTypeDefinition" },
  { "n", "gI", "editor.action.goToImplementation" },
  { "n", "<leader>e", "workbench.action.toggleSidebarVisibility" },
  { { "n", "v" }, "<leader>ca", "editor.action.codeAction" },
  { "n", "<leader>cr", "editor.action.rename" },
  { "n", "<leader>ff", "workbench.action.quickOpen" },
  { "n", "<leader>fif", "actions.find" },
  { "n", "<leader>sr", "editor.action.startFindReplaceAction" },
  { "n", "<leader>/", "workbench.action.findInFiles" },
  { "n", "<leader>ss", "workbench.action.gotoSymbol" },
  { "n", "<leader>sS", "workbench.action.showAllSymbols" },
  { "n", "<leader>qf", "editor.action.quickFix" },
  { "n", "<leader>ne", "editor.action.marker.next" },
  { "n", "<leader>Ne", "editor.action.marker.prev" },
  { "n", "<leader>rt", "workbench.action.tasks.runTask" },
  { "n", "<leader>ex", "workbench.files.action.showActiveFileInExplorer" },
  { "n", "<leader>bd", "workbench.action.closeActiveEditor" },
  { { "n", "v" }, "<leader>ai", "inlineChat.start" },
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
