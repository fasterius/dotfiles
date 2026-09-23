-- Fancier statusline
vim.pack.add({
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/fasterius/mainly.nvim",
    "https://github.com/fasterius/simple-zoom.nvim",
})

-- Set colours based on hostname; see `lua/colours.lua` for the full palettes
local palette = require("colours")
local colours
local theme
if vim.uv.os_gethostname() == "sajberspace" then
    -- Everforest colours
    local everforest = palette.everforest
    theme = require("lualine.themes.everforest")
    theme.normal.a.bg = everforest.white -- White NORMAL mode
    theme.insert.a.bg = everforest.green -- Green INSERT mode
    theme.visual.a.bg = everforest.red -- Red VISUAL mode
    theme.replace.a.bg = everforest.magenta -- Magenta REPLACE mode
    colours = {
        unzoomed_bg = everforest.black,
        zoomed_fg = everforest.background,
        zoomed_bg = everforest.blue,
    }
else
    -- Solarized colours
    local solarized = palette.solarized
    theme = require("lualine.themes.solarized")
    theme.normal.a.bg = solarized.base02 -- Black NORMAL mode
    theme.insert.a.bg = solarized.blue -- Blue INSERT mode
    theme.visual.a.bg = solarized.cyan -- Cyan VISUAL mode
    theme.replace.a.bg = solarized.orange -- Orange REPLACE mode
    theme.inactive.c.bg = solarized.base2 -- Inactive statusline
    colours = {
        unzoomed_bg = solarized.base2,
        zoomed_fg = solarized.base3,
        zoomed_bg = solarized.blue,
    }
end

-- Configure `mainly.nvim`
vim.g.mainly = {
    allowed_sources = { "local", "nf-core" },
    include_component = false,
}

-- Functions for getting filename and colours when zoomed in using the
-- `simple-zoom.nvim` and `mainly.nvim` plugins
local mainly_filename = require("mainly").filename
local function get_filename_is_zoomed_in()
    if vim.t["simple-zoom"] == nil then
        return mainly_filename()
    elseif type(vim.t["simple-zoom"]) == "table" then
        return mainly_filename() .. " 󰍉"
    end
end
local function get_colour_zoomed_in()
    if type(vim.t["simple-zoom"]) == "table" then
        return { bg = colours.zoomed_bg, fg = colours.zoomed_fg }
    else
        return { bg = colours.unzoomed_bg }
    end
end

-- Lualine setup
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = theme,
        component_separators = "|",
        section_separators = "",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = {},
        lualine_c = {
            {
                get_filename_is_zoomed_in,
                color = get_colour_zoomed_in,
            },
            { "diff" },
        },
        lualine_x = {
            { "diagnostics" },
            { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { mainly_filename },
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = {},
    },
})
