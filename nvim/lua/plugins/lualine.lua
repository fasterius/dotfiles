-- Fancier statusline
return {
    "nvim-lualine/lualine.nvim",
    config = function()
        -- Solarized colours
        local colours = {
            base3 = "#002b36",
            base2 = "#073642",
            base1 = "#586e75",
            base0 = "#657b83",
            base00 = "#839496",
            base01 = "#93a1a1",
            base02 = "#eee8d5",
            base03 = "#fdf6e3",
            yellow = "#b58900",
            orange = "#cb4b16",
            red = "#dc322f",
            magenta = "#d33682",
            violet = "#6c71c4",
            blue = "#268bd2",
            cyan = "#2aa198",
            green = "#859900",
        }

        -- Change MODE and inactive colours
        local solarized = require("lualine.themes.solarized")
        solarized.normal.a.bg = colours.base2 -- Black NORMAL mode
        solarized.insert.a.bg = colours.blue -- Blue INSERT mode
        solarized.visual.a.bg = colours.cyan -- Cyan VISUAL mode
        solarized.replace.a.bg = colours.orange -- Orange REPLACE mode
        solarized.inactive.c.bg = colours.base02 -- Inactive statusline

        -- Function to check for zoom status of the `simple-zoom.lua` plugin
        local function IsZoomedIn()
            if vim.t["simple-zoom"] == nil then
                return ""
            elseif vim.t["simple-zoom"] == "zoom" then
                return "󰍉"
            end
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
            else
                return filename
            end
        end

        -- Lualine setup
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = "|",
                section_separators = "",
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    { get_filename, file_status = false },
                    { "diff" },
                    { IsZoomedIn, color = { fg = colours.blue } },
                },
                lualine_x = {
                    { "diagnostics", sources = { "nvim_lsp" } },
                    { "filetype" },
                },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", file_status = false } },
                lualine_x = { "filetype" },
                lualine_y = {},
                lualine_z = {},
            },
        })
    end,
}
