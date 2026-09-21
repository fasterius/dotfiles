-- Autocompletion with various sources
-- Lazy load when entering Insert mode the first time
vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        vim.pack.add({
            "https://github.com/hrsh7th/nvim-cmp", -- Main completion engine
            "https://github.com/hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
            "https://github.com/hrsh7th/cmp-nvim-lsp", -- Builtin LSP source for nvim-cmp
            "https://github.com/hrsh7th/cmp-path", -- System paths source for nvim-cmp
            "https://github.com/saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
            "https://github.com/L3MON4D3/LuaSnip", -- Snippet engine in Lua
            "https://github.com/onsails/lspkind.nvim", -- Shows devicons in completion types
            "https://github.com/nvim-tree/nvim-web-devicons", -- Icons for with patched fonts
        })
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            sources = {
                { name = "buffer" },
                { name = "luasnip" },
                { name = "nvim_lsp" }, -- Neovim's built-in LSP
                { name = "otter" }, -- For Quarto documents
            },

            -- Borders around completion popups
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            -- Keymaps
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),

            -- Snippet completion from LuaSnip
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
        })

        -- Snippets via LuaSnip
        luasnip.setup({

            -- Update repeated placeholders while writing
            update_events = "TextChanged,TextChangedI",

            -- Clean up old snippets when leaving them
            region_check_events = "InsertEnter",
            delete_check_events = "InsertLeave",
        })

        -- Load snippets lazily
        require("luasnip.loaders.from_snipmate").lazy_load()
    end,
})
