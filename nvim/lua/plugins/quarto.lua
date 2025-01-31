-- Work with Quarto files
return {
    "quarto-dev/quarto-nvim",
    dependencies = {
        { "hrsh7th/nvim-cmp" },
        { "jmbuhr/otter.nvim" },
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

        -- Function to open Quarto Preview in a buffer instead of a tab
        vim.cmd([[
            function! QuartoPreview()
                :w!
                :terminal quarto preview %:p
                :call feedkeys('<Esc>')
                :bprev
            endfunction
        ]])
        vim.keymap.set("n", "<localleader>P", ":call QuartoPreview() <CR>")
    end,
}
