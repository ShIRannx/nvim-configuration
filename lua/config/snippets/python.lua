local function py_init()
  return sn(nil, c(1, { t(""), sn(1, { t(", "), i(1), d(2, py_init) }) }))
end

local function to_init_assign(args)
  local tab = {}
  local a = args[1][1]
  if #a == 0 then
    table.insert(tab, t({ "", "\tpass" }))
  else
    local cnt = 1
    for e in string.gmatch(a, " ?([^,]*) ?") do
      if #e > 0 then
        table.insert(tab, t({ "", "\tself." }))
        -- use a restore-node to be able to keep the possibly changed attribute name
        -- (otherwise this function would always restore the default, even if the user
        -- changed the name)
        local arg_name = vim.split(e, ":", true) or ""
        table.insert(tab, r(cnt, tostring(cnt), i(nil, arg_name[1])))
        table.insert(tab, t(" = "))
        table.insert(tab, t(arg_name[1]))
        cnt = cnt + 1
      end
    end
  end
  return sn(nil, tab)
end

return {
  s(
    "pyinit",
    fmt([[def __init__(self, {}) -> None:{}]], {
      d(1, py_init),
      d(2, to_init_assign, { 1 }),
    })
  ),
}
