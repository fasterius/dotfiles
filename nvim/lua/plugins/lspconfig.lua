-- Configure the built-in LSP
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "folke/neodev.nvim", config = true }, -- Additional lua configuration
    },
    config = function()
        local lspconfig = require("lspconfig")

        -- Function that runs when an LSP connects to a buffer
        local on_attach = function(client, bufnr)
            -- Generic function for implementing keymaps in attach functions
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end
                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            -- Mappings
            local lsp = vim.lsp.buf
            nmap("K", lsp.hover, "[H]over Documentation")
            nmap("gd", lsp.definition, "[G]oto [D]efinition")
            nmap("gD", lsp.declaration, "[G]oto [D]eclaration")
            nmap("gI", lsp.implementation, "[G]oto [I]mplementation")
            nmap("<leader>rn", lsp.rename, "[R]e[n]ame")
            nmap("<leader>ca", lsp.code_action, "[C]ode [A]ction")
            nmap("<leader>D", lsp.type_definition, "Type [D]efinition")

            -- Disable autoformatting for Nextflow language server
            if client.name == "nextflow_ls" then
                client.server_capabilities.documentFormattingProvider = false
            end
        end

        -- Marksman-specific attach function for Quarto, which doesn't `gd` and
        -- `K`, but rather uses the `nvim-quarto` equivalent functionality.
        local on_attach_marksman = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end
                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end
            local lsp = vim.lsp.buf
            nmap("gD", lsp.declaration, "[G]oto [D]eclaration")
            nmap("gI", lsp.implementation, "[G]oto [I]mplementation")
            nmap("<leader>rn", lsp.rename, "[R]e[n]ame")
            nmap("<leader>ca", lsp.code_action, "[C]ode [A]ction")
            nmap("<leader>D", lsp.type_definition, "Type [D]efinition")
        end

        -- Broadcast additional nvim-cmp capabilities to language servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        lspconfig.r_language_server.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig.pyright.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                },
            },
        })

        lspconfig.nextflow_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = {
                "java",
                "-jar",
                vim.fn.expand("$HOME/opt/nextflow-language-server/build/libs/language-server-all.jar"),
            },
            settings = {
                nextflow = {
                    suppressFutureWarnings = true,
                    formatting = {
                        harshilAlignment = true,
                    },
                },
            },
        })

        lspconfig.bashls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        lspconfig.marksman.setup({
            on_attach = on_attach_marksman,
            capabilities = capabilities,
            filetypes = { "markdown", "quarto" },
        })

        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    telemetry = { enable = false },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                },
            },
        })

        lspconfig.vimls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })

        -- Change diagnostic icon to a circle instead of a square
        vim.diagnostic.config({
            virtual_text = {
                prefix = "● ",
            },
        })
    end,
}
