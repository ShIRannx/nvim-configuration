local config = function() 
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()

    cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

    return {
        completion = { completeopt = "menu,menuone,noinsert" },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        sorting = defaults.sorting,
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<C-j>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ['<C-k>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.confirm({ select = true })
                elseif luasnip.choice_active() then
                    luasnip.change_choice(1)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if luasnip.choice_active(-1) then
                    luasnip.change_choice(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
        }, {
            { name = 'buffer' }
        })
    }
end

return {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "kristijanhusak/vim-dadbod-completion",
    },
    build = function()
        vim.api.nvim_create_autocmd("FileType", {
            desc = "dadbod completion",
            group = vim.api.nvim_create_augroup("dadbod_cmp", { clear = true }),
            pattern = { "sql", "mysql", "plsql" },
            callback = function() require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } } end,
        })
    end,
    opts = config
}
