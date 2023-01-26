-- Distraction-free editing
return {
    'junegunn/goyo.vim',
    cmd = 'Goyo',
    config = function()
        -- Set Goyo width to 81 to correctly wrap lines at 80 characters
        vim.g.goyo_width = 81
    end
}
