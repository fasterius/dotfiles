-- Join/split operations with Treesitter syntax
-- Defer loading to after startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/Wansmer/treesj",
    })
    require("treesj").setup({
        use_default_keymaps = false,
    })
    vim.keymap.set("n", "<leader>j", ":TSJToggle<CR>")
end)
