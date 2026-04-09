-- Emulates Tmux zoom functionality
vim.pack.add({ 'https://github.com/fasterius/simple-zoom.nvim' })

-- keys = {
--     { "<localleader>z", ":SimpleZoomToggle<CR>" },
-- },
-- cmd = "SimpleZoomToggle",

require("simple-zoom").setup({
    hide_tabline = true,
})
