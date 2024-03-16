-- Emulates Tmux zoom functionality
return {
    'fasterius/simple-zoom.nvim',
    keys = {
        { '<localleader>z', ':SimpleZoomToggle<CR>' }
    },
    cmd = 'SimpleZoomToggle',
    config = function()
        require('simple-zoom').setup {
            hide_tabline = true
        }
    end
}
