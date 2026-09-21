-- Automatically insert brackets, quotes, etc. in pairs
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup()

        -- Insert `()` after completing functions with `nvim-cmp`
        require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
}
