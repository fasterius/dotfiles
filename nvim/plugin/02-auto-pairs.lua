-- Automatically insert brackets, quotes, etc. in pairs
-- Lazy load when entering Insert mode the first time
vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        vim.pack.add({
            "https://github.com/windwp/nvim-autopairs",
        })
        require("nvim-autopairs").setup()

        -- Insert `()` after completing functions with `nvim-cmp`
        require("cmp").event:on(
            "confirm_done",
            require("nvim-autopairs.completion.cmp").on_confirm_done()
        )
    end,
})
