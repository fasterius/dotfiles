-- Surround with brackets, parentheses, quotes, etc. with Treesitter-support
return {
    "kylechui/nvim-surround",
    keys = {
        { "ys" },
        { "ds" },
        { "cs" },
    },
    config = function()
        require("nvim-surround").setup({

            -- Aliases to conform to how `targets.vim` work
            aliases = {
                ["b"] = { ")", "]", "}" },
                ["q"] = { '"', "'", "`" },
            },

            -- Do not highlight selection
            highlight = { false },
        })
    end,
}
