return {
  {
    "nvim-treesitter",
    opts = {
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["ra"] = "@assignment.rhs",
            ["la"] = "@assignment.lhs",
          },
        },
      },
    },
  },
}
