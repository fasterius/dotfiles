-- Join/split operations with Treesitter syntax
vim.pack.add({ 'https://github.com/Wansmer/treesj' })

-- keys = {
--     { "<leader>j", ":TSJToggle <CR>" },
-- },

require("treesj").setup({
    use_default_keymaps = false,
})
