-- Removes trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    once = true,
    callback = function()
        vim.pack.add({
            "https://github.com/mcauley-penney/tidy.nvim",
        })
    end,
})
