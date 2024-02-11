return {
  {
    "nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "gh", vim.lsp.buf.hover }
      keys[#keys + 1] = { "gk", vim.lsp.buf.signature_help }
    end,
  },
}
