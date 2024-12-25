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
  {
    "folke/snacks.nvim",
    opts = { scroll = { enabled = false } },
    keys = {
      { "<leader>n", false },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        trigger = {
          show_in_snippet = false,
        },
      },
    },
  },
}
