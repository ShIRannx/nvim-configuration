local config = function() 
    local null_ls = require("null-ls")
    return {
        sources = {
            null_ls.builtins.completion.spell,
            null_ls.builtins.formatting.prettier.with({ extra_args = { '--single-quote', '--arrow-parens', 'avoid' } }),
        },
    }
end
return { 
    "nvimtools/none-ls.nvim", 
    opts = config
}
