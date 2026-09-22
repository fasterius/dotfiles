-- Framework for additional text objects
-- Defer loading until after startup is finished
vim.schedule(function()
    vim.pack.add({
        -- Required by the following two plugins
        "https://github.com/kana/vim-textobj-user",
        -- `[ai]i` for indentation
        "https://github.com/kana/vim-textobj-indent",
        -- `[ai]e`, is replaced by `[ai]l` in nvim 0.13
        "https://github.com/kana/vim-textobj-entire",
    })
end)
