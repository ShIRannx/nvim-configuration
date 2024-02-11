return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        jedi_language_server = {},
        pyright = { mason = false },
      },
      setup = {
        pyright = function()
          return true
        end,
      },
    },
  },
}
