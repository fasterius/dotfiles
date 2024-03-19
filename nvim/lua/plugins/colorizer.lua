-- Highlight colour codes with the actual colours
return {
    "NvChad/nvim-colorizer.lua",
    cmd = {
        "ColorizerAttachToBuffer",
        "ColorizerToggle",
    },
    config = function()
        require("colorizer").setup({
            -- Don't colour e.g. `red` or `blue`
            user_default_options = {
                names = false,
            },
        })
    end,
}
