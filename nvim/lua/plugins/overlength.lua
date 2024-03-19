-- Highlight text longer than linelength
return {
    "lcheylus/overlength.nvim",
    config = function()
        require("overlength").setup({

            -- Solarized colour: same as cursorline
            -- TODO: not hard-coded
            colors = { bg = "#EEE8D5" },

            -- Highlight only the column itself
            highlight_to_eol = false,
        })
    end,
}
