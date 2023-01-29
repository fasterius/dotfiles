-- Fancier statusline
return {
    'nvim-lualine/lualine.nvim',
    config = function()

        -- Solarized colours
        local colours = {
            base3   =  '#002b36',
            base2   =  '#073642',
            base1   =  '#586e75',
            base0   =  '#657b83',
            base00  =  '#839496',
            base01  =  '#93a1a1',
            base02  =  '#eee8d5',
            base03  =  '#fdf6e3',
            yellow  =  '#b58900',
            orange  =  '#cb4b16',
            red     =  '#dc322f',
            magenta =  '#d33682',
            violet  =  '#6c71c4',
            blue    =  '#268bd2',
            cyan    =  '#2aa198',
            green   =  '#859900',
        }

        -- Change MODE and inactive colours
        local solarized         = require('lualine.themes.solarized')
        solarized.normal.a.bg   = colours.base2  -- Black NORMAL mode
        solarized.insert.a.bg   = colours.blue   -- Blue INSERT mode
        solarized.visual.a.bg   = colours.cyan   -- Cyan VISUAL mode
        solarized.replace.a.bg  = colours.orange -- Orange REPLACE mode
        solarized.inactive.c.bg = colours.base02 -- Inactive statusline

        -- Lualine setup
        require('lualine').setup {
            options = {
                icons_enabled        = true,
                theme                = 'solarized',
                component_separators = '|',
                section_separators   = ''
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch' },
                lualine_c = { { 'filename', file_status = false }, 'diff', },
                lualine_x = { { 'diagnostics', sources = { 'nvim_lsp' } }, 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', file_status = false } },
                lualine_x = { 'filetype' },
                lualine_y = {},
                lualine_z = {}
            }
        }
    end
}
