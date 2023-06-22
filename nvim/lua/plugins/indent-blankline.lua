return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('indent_blankline').setup {

            -- Show current indent context with different colour
            show_current_context = true,

            -- Colours
            vim.api.nvim_set_hl(0, 'IndentBlanklineChar', {fg="#EEE8D5"}),
            vim.api.nvim_set_hl(0, 'IndentBlanklineContextChar', {fg="#93A1A1"})
        }
    end
}
