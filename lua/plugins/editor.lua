return {
  {
    "neo-tree.nvim",
    opts = function(_, opts)
      local renderer = require("neo-tree.ui.renderer")
      local getSiblings = function(state, node)
        local parent = state.tree:get_node(node:get_parent_id())
        local siblings = parent:get_child_ids()
        return siblings
      end

      opts.window = vim.tbl_extend("force", opts.window or {}, {
        position = "right",
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

          -- sibling
          ["K"] = function(state)
            local node = state.tree:get_node()
            local siblings = getSiblings(state, node)
            renderer.focus_node(state, siblings[1])
          end,
          ["J"] = function(state)
            local node = state.tree:get_node()
            local siblings = getSiblings(state, node)
            renderer.focus_node(state, siblings[#siblings])
          end,
        },
      })

      return opts
    end,
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
    keys = {
      { "S", mode = "x", false },
    },
    opts = {
      search = { multi_window = false },
      modes = {
        search = { enabled = false },
        char = { enabled = false },
      },
    },
  },
}
