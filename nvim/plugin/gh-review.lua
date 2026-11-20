-- Review GitHub pull requests inside Neovim
vim.schedule(function()
    vim.pack.add({
        "https://github.com/gh-tui-tools/gh-review.nvim",
    })
    require("gh_review").setup({
        keymaps = {
            diff = {
                preview = "gK",
                comment = "gC",
            },
            files = {
                toggle_viewed = "v",
            },
        },
    })
end)
