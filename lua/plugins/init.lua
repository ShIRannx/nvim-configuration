require('core.keymaps')
require('core.options')
return {
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {
            delay = 200,
            large_file_overrides = {
                providers = { "lsp" },
            },
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        event = "VeryLazy",
        dependencies = { "tpope/vim-dadbod" },
        keys = { { '<leader>du', "<Cmd>DBUIToggle<CR>" } }
    },
    { 'j-hui/fidget.nvim', event = "VeryLazy" },
    { 'tpope/vim-sleuth', event = "VeryLazy"}, -- Detect tabstop and shiftwidth automatically

    {
        "lukas-reineke/indent-blankline.nvim", 
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        version = "v2.20.8", 
        opts = { show_current_context = true }
    },
    { 
        "numToStr/FTerm.nvim",
        event = 'VeryLazy',
        keys = {
            { '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>' },
            { '<A-i>',  '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', mode = 't' },
        }
    },
    { 'romgrk/barbar.nvim' },
    { 'towolf/vim-helm', lazy = true, ft = { "helm" } },
    { 'pearofducks/ansible-vim', lazy = true, ft = { "yaml.ansible" } },
    {
        'mg979/vim-visual-multi',
        event = "VeryLazy",
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
        event = "VeryLazy",
        config = function() require("nvim-surround").setup() end
    },

    { "christoomey/vim-tmux-navigator", event = "VeryLazy" },
    { 
        "numToStr/Comment.nvim", event = "VeryLazy",
        config = function() require('Comment').setup() end
    },
    { 'rhysd/vim-healthcheck', event = "VeryLazy" },
}
