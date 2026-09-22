-- Highlight colour codes with the actual colours
-- No lazy loading; used to be lazily loaded on commands
-- Defer loading until after startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/NvChad/nvim-colorizer.lua",
    })
    require("colorizer").setup({
        user_default_options = { names = false },
    })
end)
