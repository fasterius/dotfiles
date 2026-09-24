-- Zettelkasten through Telescope
-- Defer loading until startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/renerocksai/telekasten.nvim",
        "https://github.com/nvim-telescope/telescope.nvim",
        "https://github.com/nvim-telescope/telescope-bibtex.nvim",
        "https://github.com/nvim-lua/plenary.nvim",
    })

    -- Telescope is only used for Telekasten's pickers
    local actions = require("telescope.actions")
    require("telescope").setup({
        defaults = {
            layout_config = {
                width = 0.9,
            },
            mappings = {
                i = {
                    -- Disable scrolling inside preview windows
                    ["<C-u>"] = false,
                    ["<C-d>"] = false,
                    -- Make a single <Esc> exit Telescope
                    ["<Esc>"] = actions.close,
                    -- Send selected/whole list to quickfix list
                    ["<C-q>"] = actions.smart_send_to_qflist,
                },
            },
            -- Ignore Zettelkasten-related files
            file_ignore_patterns = {
                "templates/new_note.md",
                "zotero.bib",
            },
        },
        extensions = {
            bibtex = {
                custom_formats = {
                    -- Custom format for Zettelkasten with Telekasten plugin
                    { id = "telekasten", cite_marker = "@%s" },
                },
                citation_format = "{{author}} (**{{year}}**), _{{title}}_. [^@{{label}}]",
                -- Wrap long lines inside previewer
                wrap = true,
            },
        },
    })
    require("telescope").load_extension("bibtex")

    -- Home directory for Zettelkasten
    local home = vim.fn.expand("~/docs/zettelkasten")

    require("telekasten").setup({

        -- Home directory
        home = home,

        -- Template for new notes
        template_new_note = home .. "/templates/new_note.md",

        -- Use dropdown menus for relevant commands
        command_palette_theme = "dropdown",
        show_tags_theme = "dropdown",

        -- Note filenames are named after UUID and the title
        new_note_filename = "title",

        -- Do not create new notes with Ctrl-n in note finder picker
        enable_create_new = false,
    })

    -- Keymaps with `<leader>z` as prefix
    vim.keymap.set("n", "<leader>zf", "<CMD>Telekasten find_notes<CR>")
    vim.keymap.set("n", "<leader>zg", "<CMD>Telekasten search_notes<CR>")
    vim.keymap.set("n", "<leader>zn", "<CMD>Telekasten new_note<CR>")
    vim.keymap.set("n", "<leader>zN", "<CMD>Telekasten new_templated_note<CR>")
    vim.keymap.set("n", "<leader>zz", "<CMD>Telekasten follow_link<CR>")
    vim.keymap.set("n", "<leader>zy", "<CMD>Telekasten yank_notelink<CR>")
    vim.keymap.set("n", "<leader>zb", "<CMD>Telekasten show_backlinks<CR>")
    vim.keymap.set("n", "<leader>zt", "<CMD>Telekasten show_tags<CR>")
    vim.keymap.set("n", "<leader>zr", "<CMD>Telekasten rename_note<CR>")

    -- Telescope BibTeX extension mapping
    vim.keymap.set("n", "<leader>zB", "<CMD>Telescope bibtex<CR>")

    -- Function to delete note under cursor
    vim.cmd([[
        fun! RemoveFile()
            let file = expand("%:p")
            let choice = confirm("Remove file " .. file .. "?", "&Yes\n&No", 1)
            if choice == 1
                call delete(file) | bdelete!
            endif
        endfun
    ]])
    vim.keymap.set("n", "<leader>zR", ":call RemoveFile()<CR>")

    -- Call insert link automatically when typing double brackets
    vim.keymap.set(
        "i",
        "[[",
        "<ESC>:lua require('telekasten').insert_link({ i=true })<CR>"
    )

    -- Launch Telekasten panel if nothing more is typed after the prefix
    vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

    -- Colour highlight
    vim.cmd([[hi link tkBrackets Strikethrough]]) -- Grey
    vim.cmd([[hi link tkLink Directory]]) -- Blue
    vim.cmd([[hi link tkAliasedLink Directory]]) -- Blue

    -- Remove semantic token which interfered with above highlights
    vim.api.nvim_set_hl(0, "@lsp.type.class.telekasten", {})

    -- Conceal when in `telekasten` filetype
    vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "telekasten",
        callback = function()
            vim.o.conceallevel = 2
            vim.o.concealcursor = "nc"
        end,
    })
end)
