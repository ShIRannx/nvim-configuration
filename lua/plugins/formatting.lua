return {
    "stevearc/conform.nvim",
    lazy = true,
    dependencies = { "mason.nvim" },
    keys = {
         { 
            "<A-f>", 
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end,
            mode = { "n", "v" },
            desc = "Format buffer",
        }
    },
    opts = {
        formatters_by_ft = {
            yaml = { 'prettier' },
            ccs = { 'prettier' },
            html = { 'prettier' },
            typescript = { 'prettier' },
            javascript = { 'prettier' },
            python = { 'isort', 'black' },
        },
        formatters = {
            prettier = { prepend_args = { '--single-quote', '--arrow-parens', 'avoid' } },
        }
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
