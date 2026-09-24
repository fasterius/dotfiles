-- Zettelkasten: the `markdown-oxide` LSP  provides links, backlinks and
-- renaming, while fzf-lua provides the pickers
local zettelkasten = require("zettelkasten")

-- BibTeX citations; defer loading until startup is finished
vim.schedule(function()
    vim.pack.add({
        "https://github.com/Puerling/fzf-bibtex.nvim",
        "https://github.com/nvim-lua/plenary.nvim",
    })
    require("fzf-bibtex").setup({
        -- Find `.bib` files in the Zettelkasten regardless of the cwd
        global_files = { zettelkasten.dir },
        citation_format = "{{author}} (**{{year}}**), _{{title}}_. [^@{{citekey}}]",
    })
end)

-- Function to create a new note
local function create_note()
    -- Prompt for note name
    vim.ui.input({ prompt = "Title: " }, function(title)
        if not title or title == "" then
            return
        end
        -- Get full file path and create it with a title header, if it
        -- doesn't already exist
        local file = vim.fs.joinpath(zettelkasten.dir, title .. ".md")
        if not vim.uv.fs_stat(file) then
            vim.fn.writefile({ "# " .. title }, file)
        end
        -- Edit the file
        vim.cmd.edit(vim.fn.fnameescape(file))
    end)
end

-- Remove the current note
local function remove_note()
    local file = vim.api.nvim_buf_get_name(0)
    if vim.fn.confirm("Remove file " .. file .. "?", "&Yes\n&No", 1) == 1 then
        vim.fn.delete(file)
        vim.cmd.bdelete({ bang = true })
    end
end

-- Global keymaps
vim.keymap.set("n", "<leader>zf", function()
    require("fzf-lua").files({ cwd = zettelkasten.dir })
end)
vim.keymap.set("n", "<leader>zg", function()
    require("fzf-lua").live_grep({ cwd = zettelkasten.dir })
end)
vim.keymap.set("n", "<leader>zn", create_note)
vim.keymap.set("n", "<leader>zB", function()
    require("fzf-bibtex").search()
end)

-- Notes-only keymaps and settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(ev)
        if not zettelkasten.contains(ev.buf) then
            return
        end

        -- Conceal link syntax
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = "nc"

        -- The LSP targets whatever is under the cursor: a heading, a link
        -- (its target note) or, anywhere else, the current note itself
        local function map(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf })
        end
        map("<leader>zz", vim.lsp.buf.definition)
        map("<leader>zb", function()
            -- Always show the picker, even with a single backlink
            require("fzf-lua").lsp_references({ jump1 = false })
        end)
        map("<leader>zr", vim.lsp.buf.rename)
        map("<leader>zR", remove_note)

        -- Tags are reported as `Constant` workspace symbols
        map("<leader>zt", function()
            require("fzf-lua").lsp_workspace_symbols({
                regex_filter = "^%[Constant%]",
            })
        end)
    end,
})
