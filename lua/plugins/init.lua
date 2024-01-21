require('core.keymaps')
require('core.options')
return {
    { 'tpope/vim-sleuth', event = "VeryLazy"}, -- Detect tabstop and shiftwidth automatically
    { 
        "numToStr/FTerm.nvim",
        event = 'VeryLazy',
        keys = {
            { '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>' },
            { '<A-i>',  '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = 't' },
        }
    },
    { 'towolf/vim-helm', event = "InsertEnter", ft = { "helm" } },
    {
        'mg979/vim-visual-multi',
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        branch = 'master',
        config = function()
            vim.g.VM_maps = {
                ["I BS"] = '<C-h>', -- disable backspace mapping
            }
        end
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- for stability; omit to use `main` branch for the latest features
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function() require("nvim-surround").setup() end
    },

    { "christoomey/vim-tmux-navigator", event = "VeryLazy" },
    { 
        "numToStr/Comment.nvim", event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        config = function() require('Comment').setup() end
    },
    { 'rhysd/vim-healthcheck', event = "VeryLazy" },
}
