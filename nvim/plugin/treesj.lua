-- Join/split operations with Treesitter syntax
-- No lazy loading; used to be lazily loaded on commands/keybinds
vim.pack.add({
    "https://github.com/Wansmer/treesj",
})
require("treesj").setup({
    use_default_keymaps = false,
})
