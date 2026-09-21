-- Formatting
-- Lazy loading on first buffer write
vim.api.nvim_create_autocmd("BufWritePre", {
    once = true,
    callback = function()
        vim.pack.add({
            "https://github.com/stevearc/conform.nvim",
        })
        require("conform").setup({
            formatters_by_ft = {
                html = { "prettier" },
                lua = { "stylua" },
                markdown = { "prettier" },
                python = { "ruff" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })
    end,
})
