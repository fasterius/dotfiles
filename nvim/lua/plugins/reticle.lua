return {
    'tummetott/reticle.nvim',
    config = function()
        require('reticle').setup {
            -- Do not disable cursorline in insert mode
            disable_in_insert = false,
        }
    end
}
