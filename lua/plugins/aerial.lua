local util = require("util")

return {
  {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    opts = {},
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    keys = {
        {'<leader>f', '<cmd>AerialToggle<cr>'},
        {'{',  '<cmd>AerialPrev<CR>', { buffer = bufnr } },
        {'}',  '<cmd>AerialNext<CR>', { buffer = bufnr } },
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    optional = true,
    keys = {
      {
        "<leader>F",
        "<cmd>Telescope aerial<cr>",
        desc = "Goto Symbol (Aerial)",
      },
    },
    opts = function()
      util.on_load("telescope.nvim", function()
        require("telescope").load_extension("aerial")
      end)
    end,
  }
}