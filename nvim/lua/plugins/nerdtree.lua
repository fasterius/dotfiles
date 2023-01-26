-- Traditional, tree-based file browsing
return {
    'scrooloose/nerdtree',
    cmd = 'NERDTreeToggle',
    config = function()
        -- Quit NERDTree after opening a file
        vim.g.NERDTreeQuitOnOpen = true
        vim.keymap.set('n', '<leader>t', ':NERDTreeToggle <CR>')
    end
}
