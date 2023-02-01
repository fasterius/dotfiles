-- Work with Quarto files
return {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto', 'markdown' },
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

        -- Function to open Quarto Preview in a buffer instead of a tab
        vim.cmd [[
        function! QuartoPreview()
            :w!
            :terminal quarto preview %:p --to html
            :call feedkeys('<Esc>')
            :bprev
        endfunction
        ]]
        vim.keymap.set('n', '<localleader>P', ':call QuartoPreview() <CR>')
    end
}
