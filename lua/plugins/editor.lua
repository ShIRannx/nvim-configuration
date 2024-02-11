return {
  {
    "neo-tree.nvim",
    opts = { window = { position = "right" } },
  },
  {
    "vim-illuminate",
    opts = {
      modes_denylist = { "t" },
      filetypes_denylist = { "aerial", "mason" },
    },
  },
  {
    "flash.nvim",
    opts = {
      search = { multi_window = false },
      modes = { search = { enabled = false } },
    },
  },
}
