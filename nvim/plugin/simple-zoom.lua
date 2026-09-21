-- Emulates Tmux zoom functionality
-- No lazy loading; used to be lazily loaded on keybinds
vim.pack.add({
    "https://github.com/fasterius/simple-zoom.nvim",
})
require("simple-zoom").setup({
    hide_tabline = true,
})
