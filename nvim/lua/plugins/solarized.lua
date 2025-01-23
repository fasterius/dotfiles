-- Lua port of Solarized8 colour scheme
return {
    "ishan9299/nvim-solarized-lua",
    lazy = false,
    priority = 1000,
    config = function()
        -- Light Solarized theme
        vim.o.background = "light"
        vim.cmd([[ colorscheme solarized ]])

        -- Misspelled words are red and underlined
        vim.api.nvim_set_hl(0, "SpellBad", { fg = "#CB4B16", underline = true })

        -- Fix issues with treesitter highlights overriding background colours
        vim.api.nvim_set_hl(0, "@parameter", { fg = "#586E75" })
        vim.api.nvim_set_hl(0, "@text.emphasis", { fg = "#586E75", italic = true })
        vim.api.nvim_set_hl(0, "@text.quote", { fg = "#657B83" })
        vim.api.nvim_set_hl(0, "@text.strong", { fg = "#657B83", bold = true })
        vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = "#657B83", bold = true })
        vim.api.nvim_set_hl(0, "@label", { fg = "#657B83", bold = true })
        vim.api.nvim_set_hl(0, "@variable.parameter.r", { fg = "#657B83" })
        vim.api.nvim_set_hl(0, "@markup.italic", { fg = "#657B83", italic = true })
    end,
}

-- Solarized colour reference chart
-- See https://ethanschoonover.com/solarized/ for details
-- Base03:    #002B36;
-- Base02:    #073642;
-- Base01:    #586E75;
-- Base00:    #657B83;
-- Base0:     #839496;
-- base1:     #93A1A1;
-- base2:     #EEE8D5;
-- base3:     #FDF6E3;
-- yellow:    #B58900;
-- orange:    #CB4B16;
-- red:       #DC322F;
-- magenta:   #D33682;
-- violet:    #6C71C4;
-- blue:      #268BD2;
-- cyan:      #2AA198;
-- green:     #859900;
