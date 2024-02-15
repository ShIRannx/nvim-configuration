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
            ["ra"] = "@assignment.rhs",
            ["la"] = "@assignment.lhs",
          },
        },
      },
    },
  },
}
