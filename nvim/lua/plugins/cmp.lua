-- Autocompletion and snippets
return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-buffer', -- Buffer source for nvim-cmp
        'hrsh7th/cmp-nvim-lsp', -- Builtin LSP source for nvim-cmp
        'hrsh7th/cmp-path', -- System paths source for nvim-cmp
        'saadparwaiz1/cmp_luasnip', -- Snippet source for nvim-cmp
        'L3MON4D3/LuaSnip', -- Snippet engine in Lua
        'onsails/lspkind.nvim', -- Shows devicons in completion entry types
        'nvim-tree/nvim-web-devicons' -- Icons for with patched fonts
    },
    config = function()

        local cmp = require('cmp')
        local luasnip = require('luasnip')

        cmp.setup {
            sources = {
                { name = 'buffer'   }, -- Buffer
                { name = 'luasnip'  }, -- LuaSnips
                { name = 'nvim_lsp' }, -- Neovim's built-in LSP
                { name = 'otter'    }, -- For Quarto documents
            },
            window = { -- Borders around completion popups
                completion    = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = { -- Show devicons in completion menu
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
                end
            },
            snippet = { -- Snippets from LuaSnip
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert { -- Keymaps
                ['<C-d>']   = cmp.mapping.scroll_docs(-4),
                ['<C-f>']   = cmp.mapping.scroll_docs(4),
                ['<CR>']    = cmp.mapping.confirm { select = false, },
                ['<Tab>']   = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }
        }
    end
}
