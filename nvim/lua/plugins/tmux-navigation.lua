-- Movement between Neovim and Tmux
return {
    'alexghergh/nvim-tmux-navigation',
    config = function()
        require('nvim-tmux-navigation').setup {

            keybindings = {
                left  = "<C-h>",
                down  = "<C-j>",
                up    = "<C-k>",
                right = "<C-l>"
            },

            -- Disable movement when zoomed in to a pane
            disable_when_zoomed = true
        }
    end
}
