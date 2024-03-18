-- Autocompletion with various sources
return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-buffer',           -- Buffer source for nvim-cmp
        'hrsh7th/cmp-nvim-lsp',         -- Builtin LSP source for nvim-cmp
        'hrsh7th/cmp-path',             -- System paths source for nvim-cmp
        'saadparwaiz1/cmp_luasnip',     -- Snippet source for nvim-cmp
        'L3MON4D3/LuaSnip',             -- Snippet engine in Lua
        'onsails/lspkind.nvim',         -- Shows devicons in completion types
        'nvim-tree/nvim-web-devicons'   -- Icons for with patched fonts
    },
    config = function()

        local cmp = require('cmp')
        local luasnip = require('luasnip')

        cmp.setup {

            sources = {
                { name = 'buffer'   },
                { name = 'luasnip'  },
                { name = 'nvim_lsp' }, -- Neovim's built-in LSP
                { name = 'otter'    }, -- For Quarto documents
            },

            -- Borders around completion popups
            window = {
                completion    = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            -- Show devicons in completion menu
            formatting = {
                format = function(entry, vim_item)
                    if vim.tbl_contains({ 'path' }, entry.source.name) then
                        local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
                        if icon then
                            vim_item.kind = icon
                            vim_item.kind_hl_group = hl_group
                            return vim_item
                        end
                    end
                    return require('lspkind').cmp_format({ with_text = true })(entry, vim_item)
                end,
            },

            -- Keymaps
            mapping = cmp.mapping.preset.insert {
                ['<C-d>']   = cmp.mapping.scroll_docs(-4),
                ['<C-f>']   = cmp.mapping.scroll_docs(4),
                ['<CR>']    = cmp.mapping.confirm { select = false, },
            },

            -- Snippet completion from LuaSnip
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },

        }

        -- Snippets via LuaSnip: update repeated placeholders while writing
        luasnip.setup {
            update_events = 'TextChanged,TextChangedI'
        }

        -- Load snippets lazily
        require("luasnip.loaders.from_snipmate").lazy_load()

    end
}
