-- Work with Git merge conflicts inside Vim
-- Defer loading until after startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/sindrets/diffview.nvim",
    })
end)
