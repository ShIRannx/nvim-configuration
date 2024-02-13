return {
  {
    "neo-tree.nvim",
    opts = {
      window = { position = "right" },
      filesystem = {
        window = {
          mappings = {
            ["oc"] = "noop",
            ["od"] = "noop",
            ["og"] = "noop",
            ["om"] = "noop",
            ["on"] = "noop",
            ["os"] = "noop",
            ["ot"] = "noop",
            ["o"] = { command = "open", nowait = true },
            ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "O" } },
            ["Oc"] = { "order_by_created", nowait = false },
            ["Od"] = { "order_by_diagnostics", nowait = false },
            ["Og"] = { "order_by_git_status", nowait = false },
            ["Om"] = { "order_by_modified", nowait = false },
            ["On"] = { "order_by_name", nowait = false },
            ["Os"] = { "order_by_size", nowait = false },
            ["Ot"] = { "order_by_type", nowait = false },
          },
        },
      },
    },
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
