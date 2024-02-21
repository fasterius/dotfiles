-- Zettelkasten through Telescope
return {
    -- Use own fork of plugin for now, which includes the `enable_create_new`
    -- config settings. PR: https://github.com/renerocksai/telekasten.nvim/pull/302
    'fasterius/telekasten.nvim',
    -- 'renerocksai/telekasten.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim'
    },
    keys = {
        { "<leader>z" },
    },
    config = function()

        -- Home directory for Zettelkasten
        local home = vim.fn.expand("~/docs/zettelkasten")

        require('telekasten').setup({

            -- Home directory
            home = home,

            -- Template for new notes
            template_new_note = home .. '/templates/new_note.md',

            -- Use dropdown menus for relevant commands
            command_palette_theme = "dropdown",
            show_tags_theme = "dropdown",

            -- Note filenames are named after UUID and the title
            new_note_filename = "uuid-title",

            -- Substitute spaces in filesnames with dashes
            filename_space_subst = '-',

            -- Do not create new notes with Ctrl-n in note finder picker
            enable_create_new = false,
        })

        -- Keymaps with `<leader>z` as prefix
        vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
        vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
        vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
        vim.keymap.set("n", "<leader>zN", "<cmd>Telekasten new_templated_note<CR>")
        vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
        vim.keymap.set("n", "<leader>zy", "<cmd>Telekasten yank_notelink<CR>")
        vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
        vim.keymap.set("n", "<leader>zt", "<cmd>Telekasten show_tags<CR>")
        vim.keymap.set("n", "<leader>zr", "<cmd>Telekasten rename_note<CR>")

        -- Call insert link automatically when typing double brackets
        vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")

        -- Launch Telekasten panel if nothing more is typed after the prefix
        vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

    end
}
