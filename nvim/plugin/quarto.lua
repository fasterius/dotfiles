-- Work with Quarto files
return {
    "quarto-dev/quarto-nvim",
    dependencies = {
        { "hrsh7th/nvim-cmp" },
        { "jmbuhr/otter.nvim" },
        { "nvim-treesitter/nvim-treesitter" },
    },
    ft = "quarto",
    config = function()
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
    end,
}
