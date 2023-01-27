-- Add operators for substitutions
return {
    'svermeulen/vim-subversive',
    keys = {

        -- Substitute motion with register content
        { 's', '<plug>(SubversiveSubstitute)', mode = 'n', desc = 'Subversive' },

        -- Substitite word under cursor within motion with user input
        { '<leader>s', '<plug>(SubversiveSubstituteRange)', mode = {'n', 'x' }, desc = 'Subversive range' },

        -- Substitute word under curser within motion with user input
        { '<leader>ss', '<plug>(SubversiveSubstituteWordRange)', mode = 'n', desc = 'Subversive word range' }

    },
    config = function()

        -- Do not move cursor after substituting
        vim.g.subversivePreserveCursorPosition = 1

    end
}
