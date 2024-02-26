-- Zettelkasten through Telescope
return {
    'renerocksai/telekasten.nvim',
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
            new_note_filename = "title",

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

        -- Telescope BibTeX extension mapping
        vim.keymap.set("n", "<leader>zB", "<cmd>Telescope bibtex<CR>")

        -- Function to delete note under cursor
        vim.cmd[[
            fun! RemoveFile()
                let file = expand("%:p")
                let choice = confirm("Remove file " .. file .. "?", "&Yes\n&No", 1)
                if choice == 1
                    call delete(file) | bdelete!
                endif
            endfun
        ]]
        vim.keymap.set("n", "<leader>zR", ":call RemoveFile()<CR>")

        -- Call insert link automatically when typing double brackets
        vim.keymap.set("i", "[[", "<ESC>:lua require('telekasten').insert_link({ i=true })<CR>")

        -- Launch Telekasten panel if nothing more is typed after the prefix
        vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

    end
}
