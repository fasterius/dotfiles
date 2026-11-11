-- Show changed code in the signcolumn and other Git functionality
-- Disable on hosts with slow filesystems (Git operations are slow on LUSTRE
-- systems like Dardel); see `host.sh`
if vim.env.DOTFILES_SLOW_FS ~= "1" then
    vim.pack.add({
        "https://github.com/lewis6991/gitsigns.nvim",
    })
    require("gitsigns").setup({
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
    })
end
