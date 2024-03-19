-- Show changed code in the signcolumn and other Git functionality
return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "#eee8d5" }),
            vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "#eee8d5", fg = "#859900" }),
            vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "#eee8d5", fg = "#b58900" }),
            vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "#eee8d5", fg = "#dc322f" }),
        })
    end,
}
