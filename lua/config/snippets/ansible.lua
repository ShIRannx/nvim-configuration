local tab = function(_, snip)
  if not snip.rows then
    snip.rows = 1
  end
  local nodes = {}
  local ins_indx = 1
  for j = 1, snip.rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    table.insert(nodes, t({ "", "\t\t" }))
    ins_indx = ins_indx + 1
  end
  nodes[#nodes] = t("")
  return sn(nil, nodes)
end
local FILETYPE = "ansible"

return {
  s(
    "startup",
    fmt(
      [[
      ---
      - name: {}
        hosts: {}
        gather_facts: {}
        {}:
        {}
      ]],
      {
        i(1),
        i(2),
        c(3, { t("false"), t("true") }),
        c(4, { t("tasks"), t("roles"), t("collections") }),
        i(5),
      }
    )
  ),
  s(
    "task",
    fmt(
      [[
      - name: {}
        {}:
          {}
      ]],
      {
        i(1),
        i(2),
        d(3, tab, {}, {
          user_args = {
            function(snip)
              snip.rows = snip.rows + 1
            end,
            function(snip)
              snip.rows = math.max(snip.rows - 1, 1)
            end,
          },
        }),
      }
    )
  ),
}
