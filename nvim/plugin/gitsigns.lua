-- Show changed code in the signcolumn and other Git functionality
return {
    "lewis6991/gitsigns.nvim",
    cond = function()
        local hostname = vim.uv.os_gethostname()
        return not hostname:match("login1")
    end,
    config = function()
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
    end,
}
