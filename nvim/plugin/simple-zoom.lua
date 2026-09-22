-- Emulates Tmux zoom functionality
vim.pack.add({
    "https://github.com/fasterius/simple-zoom.nvim",
})
vim.g.simple_zoom = {
    hide_tabline = true,
}
vim.keymap.set("n", "<localleader>z", ":SimpleZoomToggle<CR>")
