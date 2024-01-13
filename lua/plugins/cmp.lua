local config = function() 
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    return {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                deprioritize_snippet,
                -- the rest of the comparators are pretty much the defaults
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.scopes,
                cmp.config.compare.score,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(), -- 取消补全，esc也可以退出
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
            { name = "copilot", group_index = 1, priority = 100},
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'buffer' }
        })
    }
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "kristijanhusak/vim-dadbod-completion",
        {
            "zbirenbaum/copilot-cmp",
            dependencies = "copilot.lua",
            opts = {},
            config = function(_, opts)
              local copilot_cmp = require("copilot_cmp")
              copilot_cmp.setup(opts)
              -- attach cmp source whenever copilot attaches
              -- fixes lazy-loading issues with the copilot cmp source
              require("util").lsp.on_attach(function(client)
                if client.name == "copilot" then
                  copilot_cmp._on_insert_enter({})
                end
              end)
            end,
        },
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
