return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'folke/neodev.nvim' -- Additional lua configuration
    },
    config = function()

        -- Function that runs when an LSP connects to a buffer
        local on_attach = function(_, bufnr)

            -- Generic function for implementing keymaps
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            -- LSP keymaps
            local lsp = vim.lsp.buf
            nmap('gd', lsp.definition, '[G]oto [D]efinition')
            nmap('gD', lsp.declaration, '[G]oto [D]eclaration')
            nmap('gI', lsp.implementation, '[G]oto [I]mplementation')
            nmap('K', lsp.hover, '[H]over Documentation')
            nmap('<leader>rn', lsp.rename, '[R]e[n]ame')
            nmap('<leader>ca', lsp.code_action, '[C]ode [A]ction')
            nmap('<leader>D', lsp.type_definition, 'Type [D]efinition')
        end

        -- Broadcast additional nvim-cmp completeion capabilities to language servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        require('lspconfig')['r_language_server'].setup {
            on_attach = on_attach
        }
        require('lspconfig')['pyright'].setup {
            on_attach = on_attach,
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true
                }
            }
        }

        require('lspconfig')['bashls'].setup {
            on_attach = on_attach
        }

        require('lspconfig')['marksman'].setup {
            on_attach = on_attach
        }

        require('lspconfig')['sumneko_lua'].setup {
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime     = { version = 'LuaJIT' },
                    diagnostics = { globals = { 'vim' } },
                    telemetry   = { enable = false },
                    workspace   = {
                        library         = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false
                    }
                }
            }
        }

        require('lspconfig')['vimls'].setup {
            on_attach = on_attach
        }

        -- Neodev setup for LSPs inside Neovim Lua config-related files
        require('neodev').setup()

    end
}
