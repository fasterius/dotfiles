-- Set colourscheme conditionally on hostname
-- See `lua/colours.lua` for the full palettes
local palette = require("colours")
if vim.uv.os_gethostname() == "sajberspace" then
    -- Everforest Dark theme
    local everforest = palette.everforest
    vim.pack.add({
        { src = "https://github.com/neanias/everforest-nvim" },
    })
    require("everforest").setup({
        background = "hard",
    })
    vim.o.background = "dark"
    require("everforest").load()

    -- Colours for `indent-blankline.lua`
    vim.api.nvim_set_hl(0, "IblIndent", { fg = everforest.indent })

    -- Telescope
    vim.api.nvim_set_hl(
        0,
        "TelescopeMatching",
        { fg = everforest.green, bold = true }
    )
else
    -- Solarized Light theme
    local solarized = palette.solarized
    vim.pack.add({
        { src = "https://github.com/ishan9299/nvim-solarized-lua" },
    })
    vim.o.background = "light"
    vim.cmd([[ colorscheme solarized ]])

    -- Misspelled words are red and underlined
    vim.api.nvim_set_hl(
        0,
        "SpellBad",
        { fg = solarized.orange, underline = true }
    )

    -- Fix issues with treesitter highlights overriding background colours
    vim.api.nvim_set_hl(0, "@parameter", { fg = solarized.base01 })
    vim.api.nvim_set_hl(
        0,
        "@text.emphasis",
        { fg = solarized.base01, italic = true }
    )
    vim.api.nvim_set_hl(0, "@text.quote", { fg = solarized.base00 })
    vim.api.nvim_set_hl(
        0,
        "@text.strong",
        { fg = solarized.base00, bold = true }
    )
    vim.api.nvim_set_hl(
        0,
        "@punctuation.delimiter",
        { fg = solarized.base00, bold = true }
    )
    vim.api.nvim_set_hl(0, "@label", { fg = solarized.base00, bold = true })
    vim.api.nvim_set_hl(0, "@variable.parameter.r", { fg = solarized.base00 })
    vim.api.nvim_set_hl(
        0,
        "@markup.italic",
        { fg = solarized.base00, italic = true }
    )
    vim.api.nvim_set_hl(
        0,
        "@markup.strong",
        { fg = solarized.base00, bold = true }
    )
    vim.api.nvim_set_hl(0, "@variable.parameter", { fg = solarized.base00 })

    -- Colours for `indent-blankline.lua`
    vim.api.nvim_set_hl(0, "IblIndent", { fg = solarized.base2 })

    -- Colours for the sign column and Git signs
    vim.api.nvim_set_hl(0, "SignColumn", { bg = solarized.base2 })
    vim.api.nvim_set_hl(
        0,
        "GitSignsAdd",
        { bg = solarized.base2, fg = solarized.green }
    )
    vim.api.nvim_set_hl(
        0,
        "GitSignsChange",
        { bg = solarized.base2, fg = solarized.yellow }
    )
    vim.api.nvim_set_hl(
        0,
        "GitSignsDelete",
        { bg = solarized.base2, fg = solarized.red }
    )

    -- Telescope colours
    vim.api.nvim_set_hl(
        0,
        "TelescopeMatching",
        { fg = solarized.blue, bold = true }
    )
end
