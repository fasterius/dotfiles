-- Work with Quarto files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "quarto",
    once = true,
    callback = function()
        vim.pack.add({
            "https://github.com/quarto-dev/quarto-nvim",
            "https://github.com/hrsh7th/nvim-cmp",
            "https://github.com/jmbuhr/otter.nvim",
            "https://github.com/nvim-treesitter/nvim-treesitter",
        })
        require("quarto").setup({
            closePreviewOnExit = true,
            lspFeatures = {
                enabled = true,
                languages = { "r", "python", "bash", "ojs" },
                chunks = "curly",
                diagnostics = {
                    enabled = true,
                    triggers = { "BufWritePost" },
                },
                completion = {
                    enabled = true,
                },
            },
        })

        -- Add Observable as JavaScript for LSP and Treesitter
        vim.filetype.add({
            extension = {
                ojs = "javascript",
            },
        })

        -- Loading happens DURING the dispatch of the first autocommand above,
        -- so the plugin misses its own trigger; re-fire that trigger after
        -- loading
        vim.schedule(function()
            vim.api.nvim_exec_autocmds(
                "FileType",
                { pattern = "quarto", modeline = false }
            )
        end)
    end,
})
