-- Surround with brackets, parentheses, quotes, etc. with Treesitter-support
-- No lazy loading; used to lazily loaded on commands
-- Defer loading until startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/kylechui/nvim-surround",
    })
    require("nvim-surround").setup({
        aliases = {
            -- Aliases to conform to how `targets.vim` work
            ["b"] = { ")", "]", "}" },
            ["q"] = { '"', "'", "`" },
        },

        -- Do not highlight selection
        highlight = { false },
    })
end)
