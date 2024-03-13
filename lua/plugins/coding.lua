return {
  {
    "mg979/vim-visual-multi",
    event = "LazyFile",
    branch = "master",
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    keys = {
      {
        mode = { "i", "s" },
        "<C-j>",
        function()
          local ls = require("luasnip")

          if ls.choice_active() then
            ls.change_choice(1)
          elseif ls.jumpable(-1) then
            _G.dynamic_node_external_update(1)
          end
        end,
      },
      {
        mode = { "i", "s" },
        "<C-k>",
        function()
          local ls = require("luasnip")

          if ls.choice_active(-1) then
            ls.change_choice(-1)
          elseif ls.jumpable(-1) then
            _G.dynamic_node_external_update(2)
          end
        end,
      },
    },
    config = function()
      local ls = require("luasnip")
      local util = require("luasnip.util.util")
      local node_util = require("luasnip.nodes.util")

      require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/config/snippets/" })

      local function find_dynamic_node(node)
        -- the dynamicNode-key is set on snippets generated by a dynamicNode only (its'
        -- actual use is to refer to the dynamicNode that generated the snippet).
        while not node.dynamicNode do
          node = node.parent
        end
        return node.dynamicNode
      end

      local external_update_id = 0
      -- func_indx to update the dynamicNode with different functions.
      function dynamic_node_external_update(func_indx)
        -- most of this function is about restoring the cursor to the correct
        -- position+mode, the important part are the few lines from
        -- `dynamic_node.snip:store()`.

        -- find current node and the innermost dynamicNode it is inside.
        local current_node = ls.session.current_nodes[vim.api.nvim_get_current_buf()]
        local dynamic_node = find_dynamic_node(current_node)

        -- to identify current node in new snippet, if it is available.
        external_update_id = external_update_id + 1
        current_node.external_update_id = external_update_id
        local current_node_key = current_node.key

        -- store which mode we're in to restore later.
        local insert_pre_call = vim.fn.mode() == "i"
        -- is byte-indexed! Doesn't matter here, but important to be aware of.
        local cursor_pos_end_relative = util.pos_sub(util.get_cursor_0ind(), current_node.mark:get_endpoint(1))

        -- leave current generated snippet.
        node_util.leave_nodes_between(dynamic_node.snip, current_node)

        -- call update-function.
        local func = dynamic_node.user_args[func_indx]
        if func then
          -- the same snippet passed to the dynamicNode-function. Any output from func
          -- should be stored in it under some unused key.
          func(dynamic_node.parent.snippet)
        end

        -- last_args is used to store the last args that were used to generate the
        -- snippet. If this function is called, these will most probably not have
        -- changed, so they are set to nil, which will force an update.
        dynamic_node.last_args = nil
        dynamic_node:update()

        -- everything below here isn't strictly necessary, but it's pretty nice to have.

        -- try to find the node we marked earlier, or a node with the same key.
        -- Both are getting equal priority here, it might make sense to give "exact
        -- same node" higher priority by doing two searches (but that would require
        -- two searches :( )
        local target_node = dynamic_node:find_node(function(test_node)
          return (test_node.external_update_id == external_update_id)
            or (current_node_key ~= nil and test_node.key == current_node_key)
        end)

        if target_node then
          -- the node that the cursor was in when changeChoice was called exists
          -- in the active choice! Enter it and all nodes between it and this choiceNode,
          -- then set the cursor.
          node_util.enter_nodes_between(dynamic_node, target_node)

          if insert_pre_call then
            -- restore cursor-position if the node, or a corresponding node,
            -- could be found.
            -- It is restored relative to the end of the node (as opposed to the
            -- beginning). This does not matter if the text in the node is
            -- unchanged, but if the length changed, we may move the cursor
            -- relative to its immediate neighboring characters.
            -- I assume that it is more likely that the text before the cursor
            -- got longer (since it is very likely that the cursor is just at
            -- the end of the node), and thus restoring relative to the
            -- beginning would shift the cursor back.
            --
            -- However, restoring to any fixed endpoint is likely to not be
            -- perfect, an interesting enhancement would be to compare the new
            -- and old text/[neighborhood of the cursor], and find its new position
            -- based on that.
            util.set_cursor_0ind(util.pos_add(target_node.mark:get_endpoint(1), cursor_pos_end_relative))
          else
            node_util.select_node(target_node)
          end
          -- set the new current node correctly.
          ls.session.current_nodes[vim.api.nvim_get_current_buf()] = target_node
        else
          -- the marked node wasn't found, just jump into the new snippet noremally.
          ls.session.current_nodes[vim.api.nvim_get_current_buf()] = dynamic_node.snip:jump_into(1)
        end
      end
    end,
  },
  {
    "mini.ai",
    opts = {
      custom_textobjects = {
        ["r"] = { { "%b[]" }, "^.().*().$" },
        ["d"] = { { '%b""' }, "^.().*().$" },
        ["s"] = { { "%b''" }, "^.().*().$" },
        ["u"] = { { "%b''", '%b""', "%b``", "%b()", "%b[]", "%b{}", "%b<>" }, "^.().*().$" },
      },
    },
  },
  {
    "mini.surround",
    opts = {
      custom_surroundings = {
        ["b"] = { input = { { "%b()" }, "^.().*().$" }, output = { left = "(", right = ")" } },
        ["d"] = { input = { { '".-"' }, "^.().*().$" }, output = { left = '"', right = '"' } },
        ["s"] = { input = { { "'.-'" }, "^.().*().$" }, output = { left = "'", right = "'" } },
        ["r"] = { input = { { "%b[]" }, "^.().*().$" }, output = { left = "[", right = "]" } },
        ["B"] = { input = { { "%b{}" }, "^.().*().$" }, output = { left = "{", right = "}" } },
        ["u"] = {
          input = { { "%b{}", "%b()", "%b[]", "%b<>", '".-"', "'.-'", "`.-`" }, "^.().*().$" },
        },
      },
      silent = true,
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
        update_n_lines = "",

        find = "fs",
        find_left = "fS",

        highlight = "",

        suffix_last = "l",
        suffix_next = "n",
      },
    },
  },
}
