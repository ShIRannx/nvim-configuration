require('core.keymaps')
require('core.options')
return {
    {
        "RRethy/vim-illuminate",
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
    {
        'stevearc/aerial.nvim',
        event = 'VeryLazy',
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter"
        },
        keys = {
            {'<leader>f', '<cmd>AerialToggle<cr>'},
            {'{',  '<cmd>AerialPrev<CR>', { buffer = bufnr } },
            {'}',  '<cmd>AerialNext<CR>', { buffer = bufnr } },
        }
    },
    { 'nvim-tree/nvim-web-devicons', lazy = true },
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
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                'prettier',
            },
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                },
            }
        }
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = {
            'j-hui/fidget.nvim',
            'folke/neodev.nvim',
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        }
    },
    { 
        "numToStr/Comment.nvim", event = "VeryLazy",
        config = function() require('Comment').setup() end
    },
    { 'rhysd/vim-healthcheck', event = "VeryLazy" },
}
