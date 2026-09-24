-- Autocompletion
vim.pack.add({
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1"),
    },
    "https://github.com/L3MON4D3/LuaSnip", -- Snippet engine in Lua
})

require("blink.cmp").setup({
    appearance = {
        -- Link kind highlights to legazy `nvim-cmp` colourschemes (required
        -- for the Solarized theme used)
        use_nvim_cmp_as_default = true,
    },

    keymap = {
        -- Default keymaps, following Vim's own completion keymaps
        --   C-n/C-p + Down/Up: Next/previous item
        --   C-y              : Accept selection (or first if no selection)
        --   C-e              : Cancel
        --   Tab/S-Tab        : Jump between snippet placeholders
        --   C-b/C-f          : Scroll documentation
        --   C-k              : Signature help
        --   Enter            : Not mapped
        preset = "default",
    },

    completion = {
        -- Do not preselect the first completion item
        list = {
            selection = { preselect = false },
        },

        -- Completion menu
        menu = {
            border = "rounded",
            -- Set columns to [kind icon, label, kind label]
            draw = {
                columns = {
                    { "kind_icon" },
                    { "label", "label_description", gap = 1 },
                    { "kind" },
                },
            },
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

-- Set the menus' background/border background to the default background colour
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelp", { link = "Normal" })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { link = "FloatBorder" })

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
