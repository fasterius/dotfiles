-- Emulates Tmux zoom functionality
-- No lazy loading; used to be lazily loaded on keybinds
vim.pack.add({
    "https://github.com/fasterius/simple-zoom.nvim",
})
vim.g.simple_zoom = {
    hide_tabline = true,
}
vim.keymap.set("n", "<localleader>z", ":SimpleZoomToggle<CR>")
