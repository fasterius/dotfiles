-- Show changed code in the signcolumn and other Git functionality
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

local hostname = vim.uv.os_gethostname()
if not hostname:match("login1") then
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
