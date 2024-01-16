local config = function()
  local ls  = require "luasnip"
  local s   = ls.snippet
  local sn  = ls.snippet_node
  local t   = ls.text_node
  local i   = ls.insert_node
  local c   = ls.choice_node
  local d   = ls.dynamic_node
  local r   = ls.restore_node
  local fmt = require("luasnip.extras.fmt").fmt

  -- see latex infinite list for the idea. Allows to keep adding arguments via choice nodes.
  local function py_init()
    return
        sn(nil, c(1, {
          t(""),
          sn(1, {
            t(", "),
            i(1),
            d(2, py_init)
          })
        }))
  end

  -- splits the string of the comma separated argument list into the arguments
  -- and returns the text-/insert- or restore-nodes
  local function to_init_assign(args)
    local tab = {}
    local a = args[1][1]
    if #(a) == 0 then
      table.insert(tab, t({ "", "\tpass" }))
    else
      local cnt = 1
      for e in string.gmatch(a, " ?([^,]*) ?") do
        if #e > 0 then
          table.insert(tab, t({ "", "\tself." }))
          -- use a restore-node to be able to keep the possibly changed attribute name
          -- (otherwise this function would always restore the default, even if the user
          -- changed the name)
          local arg_name = vim.split(e, ':', true) or ''
          table.insert(tab, r(cnt, tostring(cnt), i(nil, arg_name[1])))
          table.insert(tab, t(" = "))
          table.insert(tab, t(arg_name[1]))
          cnt = cnt + 1
        end
      end
    end
    return
        sn(nil, tab)
  end
  local function to_main_assign(args)
    local tab = {}
    local a = args[1][1]
    if #(a) == 0 then
      return sn(nil, tab)
    end

    local cnt = 1
    for e in string.gmatch(a, " ?([^,]*) ?") do
      if #e > 0 then
        table.insert(tab, t(e)) -- r(cnt, tostring(cnt), i(nil, e)))
        table.insert(tab, t(" = "))
        table.insert(tab,
          sn(cnt,
            c(1,
              {
                { r(1, tostring(cnt)), t({"", "\t"}) },
                { t('"'), r(1, tostring(cnt)),  t({ '"', "\t" }) },
                { t("("),  r(1, tostring(cnt)), t({ ")", "\t" }) },
                { t("["),  r(1, tostring(cnt)), t({ "]", "\t" }) },
                { t("{"),  r(1, tostring(cnt)), t({ "}", "\t" }) },
                {
                  t("ListNode("), r(1, tostring(cnt)), t(","),
                  r(2, "node" .. tostring(cnt)), t({ ")", "\t" })
                },
              }
            )
          )
        )
        cnt = cnt + 1
      end
    end
    return
        sn(nil, tab)
  end
  -- create the actual snippet
  ls.add_snippets("python", {
    s("pyinit",
      fmt(
        [[def __init__(self, {}) -> None:{}]],
        {
          d(1, py_init),
          d(2, to_init_assign, { 1 })
        }
      )
    ),
    s("algomain",
      fmt(
        [[
        def main() -> None:
            {}solution = Solution()
            res = solution.{}({})
            {}
        if __name__ == "__main__":
            main()
        ]],
        {
          d(3, to_main_assign, { 2 }),
          i(1),
          d(2, py_init),
          c(4, {
            t("print(f'{res=}')"),
            t({ "while res:", "\t\tprint(res.val)", "\t\tres = res.next" }),
          }
          )
        }
      )
    )
  })
end

return {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end
    },
    opts = {
      history = true, 
      delete_check_events = "TextChanged",
    },
    -- install jsregexp (optional!:).
    build = "make install_jsregexp",
    config = config
}
