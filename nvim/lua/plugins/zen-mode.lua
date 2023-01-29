-- Distraction-free editing
return {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    config = function()
        require('zen-mode').setup()
    end
}
