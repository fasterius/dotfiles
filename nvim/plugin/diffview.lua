-- Work with Git merge conflicts inside Vim
-- No lazy loading; used to be lazily loaded on commands
-- Defer loading until after startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/sindrets/diffview.nvim",
    })
end)
