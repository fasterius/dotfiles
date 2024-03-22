-- Formatting
return {
    "stevearc/conform.nvim",
    config = function()
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
}
