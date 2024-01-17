local config = function()
    local mason_lspconfig = require('mason-lspconfig')
    mason_lspconfig.setup({
        -- 确保安装，根据需要填写
        ensure_installed = {
            "pylsp",
            "tsserver",
            "angularls",
            "ansiblels",
            "emmet_ls",
            "html",
            "cssls",
            "yamlls",
            "dockerls",
            -- "docker_compose_language_service"
        },
    })

    local on_attach = function(client, bufnr)
        -- NOTE: Remember that lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself
        -- many times.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        if client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
        end

        local nmap = function(keys, func, desc)
            if desc then
                desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end
        local buf = vim.lsp.buf

        nmap('<leader>rn', buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', buf.code_action, '[C]ode [A]ction')

        nmap('gd', buf.definition, '[G]oto [D]efinition')
        nmap('gI', buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', buf.type_definition, 'Type [D]efinition')

        -- See `:help K` for why this keymap
        nmap('gh', buf.hover, 'Hover Documentation')
        nmap('gk', buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            buf.format()
        end, { desc = 'Format current buffer with LSP' })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    --Ensure the servers above are installed
    -- local mason_lspconfig = require('mason-lspconfig')

    local servers = {
        pylsp = {
            pylsp = {
                plugins = {
                    ruff = { enabled = true },
                    isort = { enabled = true },
                    jedi_completion = { fuzzy = true },
                    autopep8 = { enabled = false },
                    black = {
                        enabled = true,
                        line_length = 79,
                    },
                    yapf = { enabled = false },
                    mccabe = { enabled = false },
                    pycodestyle = { enabled = false },
                    pyflakes = { enabled = false },
                }
            }
        },
        pyright = {
            python = {
                analysis = { typeCheckingMode = 'off', diagnosticMode = 'off'}
            } 
        },
        yamlls = {
            yaml = {
                validate = false,
                format = { enable = false }
            }
        },
        html = {
            html = {
                format = { enabled = false }
            }
        },
    }

    mason_lspconfig.setup_handlers {

        function(server_name)
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name]
            }
        end,
    }
end
return {
    {
        "neovim/nvim-lspconfig",
        event="VeryLazy",
        dependencies = {
            'folke/neodev.nvim',
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = config
    },
}
