-- Work with Quarto files
vim.pack.add({
    "https://github.com/quarto-dev/quarto-nvim",
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/jmbuhr/otter.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
})

-- ft = "quarto",

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
