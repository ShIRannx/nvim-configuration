return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            { "K", false },
            { "gh", vim.lsp.buf.hover },
            { "gk", vim.lsp.buf.signature_help },
          },
        },
      },
    },
  },
}
