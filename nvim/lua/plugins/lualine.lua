-- Fancier statusline
return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local colours
        local theme
        if vim.uv.os_gethostname() == "sajberspace" then
            -- Everforest colours
            colours = {
                unzoomed_bg = "#414b50",
                zoomed_fg = "#272e33",
                zoomed_bg = "#7fbbb3",
            }
            theme = "auto"
        else
            -- Solarized colours
            local solarized = {
                base2 = "#073642",
                base02 = "#eee8d5",
                base03 = "#fdf6e3",
                orange = "#cb4b16",
                blue = "#268bd2",
                cyan = "#2aa198",
            }
            theme = require("lualine.themes.solarized")
            theme.normal.a.bg = solarized.base2 -- Black NORMAL mode
            theme.insert.a.bg = solarized.blue -- Blue INSERT mode
            theme.visual.a.bg = solarized.cyan -- Cyan VISUAL mode
            theme.replace.a.bg = solarized.orange -- Orange REPLACE mode
            theme.inactive.c.bg = solarized.base02 -- Inactive statusline
            colours = {
                unzoomed_bg = solarized.base02,
                zoomed_fg = solarized.base03,
                zoomed_bg = solarized.blue,
            }
        end

        -- Function to get the current filename: if the current filename equals
        -- `main.nf` also include the parent directory, otherwise just return
        -- the filename itself (useful for working with nf-core).
        -- The filename modifiers used are:
        --     :t   - "Tail", just the filename
        --     :p   - "Path", the full file path
        --     :h   - "Head", the everything except the filename
        --     :h:t - A combination that gets only the parent directory
        local function get_filename()
            local filename = vim.fn.expand("%:t")
            if filename == "main.nf" then
                local filepath = vim.fn.expand("%:p")
                local parent_dir = vim.fn.fnamemodify(filepath, ":h:t")
                return parent_dir .. "/" .. filename
            elseif filename == "main.nf.test" then
                local filepath = vim.fn.expand("%:p")
                local grandparent_dir = vim.fn.fnamemodify(filepath, ":h:h:t")
                local parent_dir = vim.fn.fnamemodify(filepath, ":h:t")
                return grandparent_dir .. "/" .. parent_dir .. "/" .. filename
            else
                return filename
            end
        end

        -- Functions for getting filename and colours when zoomed in using the
        -- `simple-zoom.nvim` plugin
        local function get_filename_is_zoomed_in()
            local filename = get_filename()
            if vim.t["simple-zoom"] == nil then
                return filename
            elseif vim.t["simple-zoom"] == "zoom" then
                return filename .. " 󰍉"
            end
        end
        local function get_colour_zoomed_in()
            if vim.t["simple-zoom"] == "zoom" then
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
                        file_status = false,
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
                lualine_c = { { get_filename, file_status = false } },
                lualine_x = { "filetype" },
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}
