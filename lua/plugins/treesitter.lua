require('nvim-treesitter.configs').setup {
    -- 添加不同语言
    ensure_installed = {
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
        "yaml"
    },

    highlight = { enable = true },
    -- indent = { enable = true },
    indent = { enable = true, disable = { "python", "yaml" } },

    -- 不同括号颜色区分
    -- rainbow = {
    -- enable = true,
    -- extended_mode = true,
    -- max_file_lines = nil,
    -- }
}
vim.treesitter.language.register("yaml", "yaml.ansible")
