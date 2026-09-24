-- Local plugin `zettelkasten`
-- The `markdown-oxide` LSP  provides links, backlinks and renaming, while
-- `fzf-lua` provides the pickers
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

-- Two steps: first select a tag (`Constant`) from the available workspace
-- symbols in `markdown-oxide`, then search for all notes with that tag with the
-- normal file picker
local function search_tags()
    local fzf = require("fzf-lua")
    -- Only run when `markdown-oxide` is running
    local client =
        vim.lsp.get_clients({ bufnr = 0, name = "markdown-oxide" })[1]
    if not client then
        return
    end
    -- Get workspace symbols
    client:request("workspace/symbol", { query = "" }, function(err, result)
        if err or not result then
            return
        end
        -- Group the occurrences by tag, as `file:line:col` entries
        local tags = {}
        for _, symbol in ipairs(result) do
            if symbol.kind == vim.lsp.protocol.SymbolKind.Constant then
                local file = vim.uri_to_fname(symbol.location.uri)
                local start = symbol.location.range.start
                tags[symbol.name] = tags[symbol.name] or {}
                table.insert(
                    tags[symbol.name],
                    string.format(
                        "%s:%d:%d:",
                        vim.fs.relpath(zettelkasten.dir, file) or file,
                        start.line + 1,
                        start.character + 1
                    )
                )
            end
        end
        local names = vim.tbl_keys(tags)
        table.sort(names)
        -- Step 1: search among found tags
        fzf.fzf_exec(names, {
            prompt = "Tags> ",
            -- Step 2: search among found (tagged) files
            actions = {
                ["enter"] = function(selected)
                    fzf.fzf_exec(tags[selected[1]], {
                        prompt = selected[1] .. "> ",
                        cwd = zettelkasten.dir,
                        previewer = "builtin",
                        actions = fzf.defaults.actions.files,
                    })
                end,
            },
        })
    end, 0)
end

-- Global keymaps (no icons; all notes are Markdown)
vim.keymap.set("n", "<leader>zf", function()
    require("fzf-lua").files({ cwd = zettelkasten.dir, file_icons = false })
end)
vim.keymap.set("n", "<leader>zg", function()
    require("fzf-lua").live_grep({ cwd = zettelkasten.dir, file_icons = false })
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
        map("<leader>zz", vim.lsp.buf.definition) -- Go to note
        map("<leader>zb", function() -- List backlinks
            -- Always show the picker, even with a single backlink
            require("fzf-lua").lsp_references({
                jump1 = false,
                file_icons = false,
            })
        end)
        map("<leader>zr", vim.lsp.buf.rename)
        map("<leader>zR", remove_note)
        map("<leader>zt", search_tags)
    end,
})
