-- Formatting
-- Lazy loading on first buffer write
vim.api.nvim_create_autocmd("BufWritePre", {
    once = true,
    callback = function(args)
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
                lsp_format = "fallback",
            },
        })

        -- `setup()` registers conform's own `BufWritePre` autocommand during
        -- the dispatch of this one, so it misses this write; run it directly
        vim.api.nvim_exec_autocmds(
            "BufWritePre",
            { group = "Conform", buf = args.buf, modeline = false }
        )
    end,
})
