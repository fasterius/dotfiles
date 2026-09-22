-- Alignment around arbitrary characters
-- No lazy loading; used to be lazily loaded on commands
-- Defer loading until startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/junegunn/vim-easy-align",
    })
end)
