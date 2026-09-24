-- Fuzzy finding with fzf-lua
vim.pack.add({
    "https://github.com/ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")
fzf.setup({
    -- Generate fzf's colours from the current colourscheme
    fzf_colors = true,

    winopts = {
        width = 0.9,
    },

    -- Ignore Zettelkasten-related files
    file_ignore_patterns = {
        "templates/new_note.md",
        "zotero.bib",
    },

    actions = {
        files = {
            true, -- Keep the default actions
            -- Send the whole list to the quickfix list (`alt-q` sends only
            -- the selected items)
            ["ctrl-q"] = {
                fn = fzf.actions.file_sel_to_qf,
                prefix = "select-all",
            },
        },
    },
})

-- Finding files
vim.keymap.set("n", "<leader>fg", fzf.git_files)
vim.keymap.set("n", "<leader>ff", fzf.files)
vim.keymap.set("n", "<leader>fb", fzf.buffers)

-- Searching
local function git_root()
    return fzf.path.git_root({}, true)
end
vim.keymap.set("n", "<leader>sg", function()
    fzf.live_grep({ cwd = git_root })
end)
vim.keymap.set("n", "<leader>sw", function()
    fzf.grep_cword({ cwd = git_root })
end)
vim.keymap.set("n", "<leader>sh", fzf.helptags)
vim.keymap.set("n", "<leader>sd", fzf.diagnostics_workspace)

-- LSP
vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols)
vim.keymap.set("n", "<leader>ws", fzf.lsp_live_workspace_symbols)
vim.keymap.set("n", "gr", fzf.lsp_references)

-- Open `git_files` or `files` when Neovim is called without a specific file
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Don't run if the filetype is `man` (Neovim is used as a manpager)
        if vim.bo.filetype == "man" then
            return
        end
        if next(vim.fn.argv()) == nil then
            -- Defer to until after full start-up is done
            vim.schedule(function()
                if fzf.path.is_git_repo({}, true) then
                    fzf.git_files()
                else
                    fzf.files()
                end
            end)
        end
    end,
})
