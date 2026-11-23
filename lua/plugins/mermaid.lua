return {
  {
    "kevalin/mermaid.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      -- To enable diagnostics, install with `npm install -g @mermaid-js/mermaid-cli`
      -- and change this to `enabled = true`.
      lint = { enabled = false },
      preview = {
        -- renderer = "beautiful-mermaid", -- "mermaid.js" or "beautiful-mermaid"
        theme = "default", -- Theme name (renderer-specific)
      },
    },
    config = function(_, opts)
      require("mermaid").setup(opts)
      require("mermaid.panel").open = function() end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "mermaid" })
    end,
  },
}
