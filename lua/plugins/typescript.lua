return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          root_dir = function(bufnr, on_dir)
            local root = vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", "package.json" })
            on_dir(root or vim.fn.getcwd())
          end,
          settings = {
            typescript = {
              suggest = {
                autoImports = true,
                includeCompletionsForModuleExports = true,
              },
              preferences = {
                includePackageJsonAutoImports = "on",
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                importModuleSpecifier = "project-relative",
              },
            },
            javascript = {
              suggest = {
                autoImports = true,
                includeCompletionsForModuleExports = true,
              },
              preferences = {
                includePackageJsonAutoImports = "on",
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
                importModuleSpecifier = "project-relative",
              },
            },
          },
        },
      },
    },
  },
}
