-- Work with Quarto files
return {
    'quarto-dev/quarto-nvim',
    ft = 'quarto',
    dependencies = 'jmbuhr/otter.nvim',
    config = function()
        require('quarto').setup {
            lspFeatures = {
                enabled     = true,
                languages   = { 'r', 'python' },
                diagnostics = { enabled = true, triggers = { "BufWrite" } },
                cmpSource   = { enabled = true }
            }
        }
    end
}
