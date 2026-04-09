-- Disable cursorline for inactive splits
vim.pack.add({ 'https://github.com/tummetott/reticle.nvim' })

require("reticle").setup({
    -- Do not disable cursorline in insert mode
    disable_in_insert = false,
})
