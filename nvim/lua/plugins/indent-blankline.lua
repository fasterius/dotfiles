return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('ibl').setup {

            -- Do not show scope
            scope = { enabled = false },

            -- Colours
            vim.api.nvim_set_hl(0, 'IblIndent', {fg="#EEE8D5"}),

        }

        -- Hide first indentation level
        local hooks = require("ibl.hooks")
        hooks.register(
            hooks.type.WHITESPACE,
            hooks.builtin.hide_first_space_indent_level
        )
    end
}
