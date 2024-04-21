return {
  {
    "nvim-lspconfig",
    opts = {
      servers = { ruff_lsp = { mason = false } },
      setup = {
        ruff_lsp = function()
          return true
        end,
      },
    },
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "ruff" })
    end,
  },
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
