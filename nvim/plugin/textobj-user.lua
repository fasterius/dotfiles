-- Framework for additional text objects
-- Defer loading until after startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/kana/vim-textobj-user",
        "https://github.com/kana/vim-textobj-entire",
        "https://github.com/kana/vim-textobj-indent",
        "https://github.com/kana/vim-textobj-line",
    })
end)
