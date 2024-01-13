require('core.keymaps')
require('core.options')
return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            markdown = true,
            help = true,
          },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        keys = {
            {'<leader>db', '<CMD> DapToggleBreakpoint <CR>'},
            {'<leader>d', function() require('dap').continue() end },
        },
        dependencies = {
            "mfussenegger/nvim-dap"
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close
        end
    },
    { "mfussenegger/nvim-dap", event = "VeryLazy" },
    {
        "mfussenegger/nvim-dap-python",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function()
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        event = "VeryLazy",
        dependencies = { "tpope/vim-dadbod" },
        keys = { { '<leader>du', "<Cmd>DBUIToggle<CR>" } }
    },
    { 'j-hui/fidget.nvim' },
    { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically

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
        event = "VeryLazy",
        keys = {
            {'<leader>f', '<cmd>AerialToggle<cr>'},
            {'{',  '<cmd>AerialPrev<CR>', { buffer = bufnr } },
            {'}',  '<cmd>AerialNext<CR>', { buffer = bufnr } },
        }
    },
    {
        'romgrk/barbar.nvim',
        dependencies = 'nvim-web-devicons',
    },
    { 'towolf/vim-helm', event = "VeryLazy" },
    { 'pearofducks/ansible-vim' , event = "VeryLazy" },
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
        event = "VeryLazy"
    },

    { "christoomey/vim-tmux-navigator", event = "VeryLazy"},
    {
        "williamboman/mason.nvim",
        opts = {
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

-- require("core.keymaps")
-- require("core.options")
-- require('lazy').setup(plugins)
