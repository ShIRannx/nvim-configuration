return {
  {
    "nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "sql" })
    end,
  },
  {
    "nvim-cmp",
    ft = { "sql", "mysql", "plsql" },
    dependencies = { "kristijanhusak/vim-dadbod-completion" },
    build = function()
      vim.api.nvim_create_autocmd("FileType", {
        desc = "dadbod completion",
        group = vim.api.nvim_create_augroup("dadbod_cmp", { clear = true }),
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
        end,
      })
    end,
  },
}
