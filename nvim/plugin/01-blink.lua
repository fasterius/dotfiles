-- Autocompletion
vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1"),
    },
    "https://github.com/L3MON4D3/LuaSnip", -- Snippet engine in Lua
})

require("blink.cmp").setup({
    keymap = {
        preset = "none",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-d>"] = {
            function(cmp)
                cmp.scroll_documentation_up(4)
            end,
        },
        ["<C-f>"] = {
            function(cmp)
                cmp.scroll_documentation_down(4)
            end,
        },
    },

    completion = {
        -- Only accept an item that was explicitly navigated to
        list = {
            selection = { preselect = false },
        },

        -- Borders around completion popups
        menu = {
            border = "rounded",
        },
        documentation = {
            auto_show = true,
            window = { border = "rounded" },
        },

        -- Insert `()` after completing functions/methods
        accept = {
            auto_brackets = { enabled = true },
        },
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    snippets = { preset = "luasnip" },
})

-- LuaSnip configuration
require("luasnip").setup({

    -- Update repeated placeholders while writing
    update_events = "TextChanged,TextChangedI",

    -- Clean up old snippets when leaving them
    region_check_events = "InsertEnter",
    delete_check_events = "InsertLeave",
})

-- Load snippets lazily
require("luasnip.loaders.from_snipmate").lazy_load()
