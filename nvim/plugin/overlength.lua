-- Highlight text longer than linelength
vim.pack.add({ 'https://github.com/lcheylus/overlength.nvim' })

-- Get highlight of CursorLine for overlength colour specification
local hl = vim.api.nvim_get_hl_by_name("CursorLine", true)

-- Plugin config
require("overlength").setup({

    -- Set colour of overlength to the same as CursorLine colour group
    colors = { bg = hl.background },

    -- Highlight only the column itself
    highlight_to_eol = false,

    -- Disable in C files
    disable_ft = { "c" },

})
