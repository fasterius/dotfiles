return {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    -- Only use this on Linux systems
    cond = function()
        return vim.uv.os_gethostname() == "sajberspace"
    end,
    config = function()
        -- Plugin config
        require("everforest").setup({
            background = "hard",
        })

        -- Load plugin
        vim.o.background = "dark"
        require("everforest").load()

        -- Colours for `indent-blankline.lua`
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2e383c" })

        -- Telescope
        vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#a7c080", bold = true })
    end,
}

-- Everforest [hard, dark] reference chart
-- background:   '#272e33'
-- foreground:   '#d3c6aa'
-- black:        '#414b50'
-- bright black: '#475258'
-- red:          '#e67e80'
-- green:        '#a7c080'
-- yellow:       '#dbbc7f'
-- blue:         '#7fbbb3'
-- magenta:      '#d699b6'
-- cyan:         '#83c092'
-- white:        '#d3c6aa'
