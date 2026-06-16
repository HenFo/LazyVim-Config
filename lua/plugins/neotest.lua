return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
    },
    opts = {
      adapters = {
        ["neotest-vitest"] = {
          vitestCommand = "pnpm exec vitest",
          vitestConfigFile = "vite.config.ts",
        },
      },
    },
  },
}
