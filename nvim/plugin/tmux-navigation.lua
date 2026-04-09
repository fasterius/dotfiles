-- Movement between Neovim and Tmux
vim.pack.add({ 'https://github.com/christoomey/vim-tmux-navigator' })

-- keys = {
-- { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
-- { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
-- { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
-- { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
-- },

-- Disable movement when zoomed in to a pane
vim.cmd([[ let g:tmux_navigator_disable_when_zoomed = 1 ]])

-- Disable edge wrapping
vim.cmd([[ let g:tmux_navigator_no_wrap = 1 ]])
