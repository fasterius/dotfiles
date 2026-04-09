-- Surround with brackets, parentheses, quotes, etc. with Treesitter-support
vim.pack.add({ 'https://github.com/kylechui/nvim-surround' })

-- keys = {
--     { "ys" },
--     { "ds" },
--     { "cs" },
-- },

require("nvim-surround").setup({

    -- Aliases to conform to how `targets.vim` work
    aliases = {
	["b"] = { ")", "]", "}" },
	["q"] = { '"', "'", "`" },
    },

    -- Do not highlight selection
    highlight = { false },
})
