-- Traditional, tree-based file browsing
-- No lazy loading; used to be lazily loaded on commands
-- Defer loading until after startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/nvim-tree/nvim-tree.lua",
        "https://github.com/nvim-tree/nvim-web-devicons",
    })
    require("nvim-tree").setup({
        -- close browser after opening a file
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
    })
end)
