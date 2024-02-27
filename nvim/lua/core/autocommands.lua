-- Set formatoptions globally (overrides filetype-specific settings)
--   Auto-wrap comments using 'textwidth' (c)
--   Allow `gq`-formatting of comments (q)
--   Auto-wrap text using 'textwidth' (t)
--   Remove comment leader when joining lines (j)
--   Auto-wrap lists to follow list element indentation (n)
vim.api.nvim_create_autocmd({'FileType'}, {
    pattern = '*',
    command = ':set formatoptions=cjqtn',
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

-- Open Telescope's `find_files` or `git_files` when Neovim is called
-- without a specific file to open
vim.api.nvim_create_autocmd({'VimEnter'}, {
    callback = function()
        if next(vim.fn.argv()) == nil then
            if os.execute('git rev-parse --is-inside-work-tree >> /dev/null 2>&1') == 0 then
                require('telescope.builtin').git_files()
            else
                require('telescope.builtin').find_files()
            end
        end
    end
})
