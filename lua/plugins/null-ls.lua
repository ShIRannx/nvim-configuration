local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier.with({ extra_args = { '--single-quote', '--arrow-parens', 'avoid' } }),
    -- null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
    -- null_ls.builtins.formatting.isort,
    --null_ls.builtins.completion.spell,
  },
})
