local config = function() 
    local null_ls = require("null-ls")
    return {
        sources = {
            null_ls.builtins.formatting.prettier.with({ extra_args = { '--single-quote', '--arrow-parens', 'avoid' } }),
        },
    }
end
return { 
    "nvimtools/none-ls.nvim", 
    ft = { "javascript", "typescript", "typescriptreact", "javascriptreact", "json", "yaml", "html", "css", "scss", "markdown"},
    event = "VeryLazy",
    opts = config
}
