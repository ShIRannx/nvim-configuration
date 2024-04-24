return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = { auto_brackets = {} },
  },
}
