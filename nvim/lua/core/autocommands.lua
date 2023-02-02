-- Set formatoptions globally (overrides filetype-specific settings)
--   Auto-wrap comments using 'textwidth' (c)
--   Allow `gq`-formatting of comments (q)
--   Auto-wrap text using 'textwidth' (t)
--   Remove comment leader when joining lines (j)
vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = '*',
    command = ':set formatoptions=cjqt',
})

-- Go to INSERT mode when moving to a terminal pane
vim.api.nvim_create_autocmd({'TermOpen', 'BufEnter', 'BufWinEnter'}, {
    pattern = {'term://*'},
    command = ':startinsert'
})

-- Go to NORMAL mode when moving from a terminal pane
vim.api.nvim_create_autocmd({'BufLeave', 'BufWinLeave'}, {
    pattern = {'term://*'},
    command = ':stopinsert'
})

-- Bypass [Process exited 0] prompt after closing a terminal
vim.api.nvim_create_autocmd({'TermClose'}, {
    pattern = {'*'},
    command = ':execute "bdelete! " . expand("<abuf>")'
})

-- Disable line numbers in terminals
vim.api.nvim_create_autocmd({'TermOpen'}, {
    pattern = {'*'},
    command = ':setlocal nonumber norelativenumber nocursorline'
})
