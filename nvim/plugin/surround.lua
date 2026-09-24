-- Surround with brackets, parentheses, quotes, etc. with Treesitter-support
-- Defer loading until startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/kylechui/nvim-surround",
    })
    require("nvim-surround").setup()
end)
