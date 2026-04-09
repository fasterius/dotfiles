-- Automatically insert brackets, quotes, etc. in pairs
vim.pack.add({ 'https://github.com/windwp/nvim-autopairs' })

require("nvim-autopairs").setup({

    -- Insert `()` after completing functions with `nvim-cmp`
    require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

})
