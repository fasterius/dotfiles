-- Movement between Neovim and Tmux
-- No lazy loading; used to be lazily loaded on keymaps
vim.pack.add({
    "https://github.com/christoomey/vim-tmux-navigator",
})

-- Disable movement when zoomed in to a pane
vim.cmd([[ let g:tmux_navigator_disable_when_zoomed = 1 ]])

-- Disable edge wrapping
vim.cmd([[ let g:tmux_navigator_no_wrap = 1 ]])

-- Move between Neovim splits and Tmux panes seamlessly
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
