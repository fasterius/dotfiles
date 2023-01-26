-- Add operators for substitution
return {
    'svermeulen/vim-subversive',
    config = function()

        -- Substitute motion with register content
        vim.keymap.set('n', 's', '<plug>(SubversiveSubstitute)')

        -- Substitite word under cursor within motion with user input
        vim.keymap.set('n', '<leader>s', '<plug>(SubversiveSubstituteRange)')
        vim.keymap.set('x', '<leader>s', '<plug>(SubversiveSubstituteRange)')

        -- Substitute word under curser within motion with user input
        vim.keymap.set('n', '<leader>ss', '<plug>(SubversiveSubstituteWordRange)')

        -- Do not move cursor after substituting
        vim.g.subversivePreserveCursorPosition = 1

    end
}
