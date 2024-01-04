-- 自动安装packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- 保存此文件自动更新安装软件
-- 注意PackerCompile改成了PackerSync
-- plugins.lua改成了plugins-setup.lua，适应本地文件名字
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- use 'github/copilot.vim'

    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            "mfussenegger/nvim-dap"
        }
    }
    use "mfussenegger/nvim-dap"

    use {
        "mfussenegger/nvim-dap-python",
        requires = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        }
    }
    use {
        "kristijanhusak/vim-dadbod-ui",
        requires = {
            "tpope/vim-dadbod",
        }
    }
    use { 'j-hui/fidget.nvim' }
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
    use 'Mofiqul/vscode.nvim'
    -- use "EdenEast/nightfox.nvim"
    use {"lukas-reineke/indent-blankline.nvim", tag = "v2.20.8"}
    use "numToStr/FTerm.nvim"
    use 'stevearc/aerial.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use {
        'romgrk/barbar.nvim',
        wants = 'nvim-web-devicons',
    }
    use 'towolf/vim-helm'
    use 'pearofducks/ansible-vim'

    use {
        'mg979/vim-visual-multi',
        branch = 'master',
    }

    use {
        'folke/flash.nvim'
    }

    -- use 'tpope/vim-surround'
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    })

    use {
        'nvim-lualine/lualine.nvim', -- 状态栏
        -- requires = { 'kyazdani42/nvim-web-devicons', opt = true } -- 状态栏图标
    }
    use {
        'nvim-tree/nvim-tree.lua',         -- 文档树
        requires = {
            'nvim-tree/nvim-web-devicons', -- 文档树图标
        }
    }
    use "christoomey/vim-tmux-navigator" -- 用ctl-hjkl来定位窗口
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    -- use 'Vimjas/vim-python-pep8-indent'
    use({
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    })
    use {
        "neovim/nvim-lspconfig",
        requires = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
            'j-hui/fidget.nvim',
            'folke/neodev.nvim'
        }
    }
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*",
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })
    -- 自动补全
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lsp",
            -- "L3MON4D3/LuaSnip", -- snippets引擎，不装这个自动补全会出问题
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-path", -- 文件路径
            "kristijanhusak/vim-dadbod-completion",
        },
        run = function()
            vim.api.nvim_create_autocmd("FileType", {
                desc = "dadbod completion",
                group = vim.api.nvim_create_augroup("dadbod_cmp", { clear = true }),
                pattern = { "sql", "mysql", "plsql" },
                callback = function() require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } } end,
            })
        end
    }
    use "rafamadriz/friendly-snippets"
    use 'jose-elias-alvarez/null-ls.nvim'
    -- use 'mhartington/formatter.nvim'

    use 'rhysd/vim-healthcheck'
    use {
        "folke/noice.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    }
    use "numToStr/Comment.nvim"   -- gcc和gc注释
    use "windwp/nvim-autopairs"   -- 自动补全括号

    use "lewis6991/gitsigns.nvim" -- 左则git提示

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4', -- 文件检索
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)
