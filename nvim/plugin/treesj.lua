-- Join/split operations with Treesitter syntax
return {
    "Wansmer/treesj",
    keys = {
        { "<leader>j", ":TSJToggle <CR>" },
    },
    config = function()
        require("treesj").setup({
            use_default_keymaps = false,
        })
    end,
}
