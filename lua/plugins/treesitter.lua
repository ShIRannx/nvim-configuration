return {
  {
    "nvim-treesitter",
    init = function()
      vim.treesitter.language.register("yaml", "yaml.ansible")
    end,
    opts = {
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["if"] = "@function.inner",
            ["af"] = "@function.outer",
            ["ra"] = "@assignment.rhs",
            ["la"] = "@assignment.lhs",
            ["ic"] = "@class.inner",
            ["ac"] = "@class.outer",
            ["io"] = "@conditional.inner",
            ["ao"] = "@conditional.outer",
            ["il"] = "@loop.inner",
            ["al"] = "@loop.outer",
            ["am"] = "@comment.outer",
            ["im"] = "@comment.inner",
          },
        },
      },
    },
  },
}
