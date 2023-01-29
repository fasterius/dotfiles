-- Add operators for substitutions
return {
    'gbprod/substitute.nvim',
    keys = {
        { 's',         mode = { 'n', 'x' } },
        { '<leader>s', mode = { 'n', 'x' } },
        { '<leader>ss'                     }
    },
    config = function()
        require("substitute").setup()

        -- Substitute
        local substitute = require('substitute')
        vim.keymap.set("n", "s",  substitute.operator, { noremap = true })
        vim.keymap.set("x", "s",  substitute.visual,   { noremap = true })
        vim.keymap.set("n", "ss", substitute.line,     { noremap = true })
        vim.keymap.set("n", "S",  substitute.eol,      { noremap = true })

        -- Substitute over range
        local range = require('substitute.range')
        vim.keymap.set("n", "<leader>s",  range.operator, { noremap = true })
        vim.keymap.set("x", "<leader>s",  range.visual,   { noremap = true })
        vim.keymap.set("n", "<leader>ss", range.word,     { noremap = true })
    end
}
