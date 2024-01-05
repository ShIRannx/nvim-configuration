require('nvim-treesitter.configs').setup {
    -- 添加不同语言
    ensure_installed = {
        "c",
        "bash",
        "javascript",
        "json",
        "lua",
        "python",
        "typescript",
        "tsx",
        "html",
        "sql",
        "go",
        "css",
        "rust",
        "yaml",
        "groovy",
        "lua"
    },

    indent = { enable = true, disable = { "yaml" } },
    highlight = { enable = true },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ['if'] = '@function.inner',
                ['af'] = '@function.outer',
                ['ia'] = '@assignment.inner',
                ['aa'] = '@assignment.outer',
                ['ra'] = '@assignment.rhs',
                ['la'] = '@assignment.lhs',
                ['as'] = '@statement.outer',
                ['ic'] = '@class.inner',
                ['ac'] = '@class.outer',
                ['io'] = '@conditional.inner',
                ['ao'] = '@conditional.outer',
                ['il'] = '@loop.inner',
                ['al'] = '@loop.outer',
            }
        }
    }

    -- 不同括号颜色区分
    -- rainbow = {
    -- enable = true,
    -- extended_mode = true,
    -- max_file_lines = nil,
    -- }
}
vim.treesitter.language.register("yaml", "yaml.ansible")
