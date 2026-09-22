-- Join/split operations with Treesitter syntax
-- No lazy loading; used to be lazily loaded on commands/keybinds
-- Defer loading to after startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/Wansmer/treesj",
    })
    require("treesj").setup({
        use_default_keymaps = false,
    })
end)
