-- Fuzzy finding with fzf-lua
vim.pack.add({
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

local fzf = require("fzf-lua")
fzf.setup({
    -- Generate `fzf`'s colours from the colourscheme and link `fzf-lua`'s
    -- highlights (several are hardcoded by default) to the colourscheme groups
    fzf_colors = true,
    hls = {
        fzf = {
            match = "Directory",
            prompt = "Directory",
            pointer = "Directory",
            marker = "Directory",
            spinner = "Directory",
        },
        header_text = "Comment",
        header_bind = "Directory",
        path_linenr = "Comment",
        path_colnr = "Comment",
        live_prompt = "Normal",
        live_sym = "Directory",
        buf_nr = "Comment",
        buf_flag_cur = "Directory",
        buf_flag_alt = "Comment",
    },

    -- `ripgrep` colours grep results itself, so it can't use the groups above;
    -- `cyan`/`blue` are the colourscheme's terminal colours, 245 is grey
    grep = {
        rg_opts = "--column --line-number --no-heading --color=always "
            .. "--smart-case --max-columns=4096 "
            .. "--colors=path:fg:cyan "
            .. "--colors=line:fg:245 "
            .. "--colors=column:fg:245 "
            .. "--colors=match:fg:blue "
            .. "-e", -- Flag signifies that the next argument is the pattern
    },

    -- No git status column in `git_files`, which is blank for unchanged files
    git = {
        files = {
            git_icons = false,
        },
    },

    winopts = {
        -- Set window width to 90% of Neovim's width
        width = 0.9,
        -- Don't dim the buffers behind the picker
        backdrop = false,
    },

    -- Ignore Zettelkasten-related files
    file_ignore_patterns = {
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
    fzf.live_grep({ cwd = git_root() })
end)
vim.keymap.set("n", "<leader>sw", function()
    fzf.grep_cword({ cwd = git_root() })
end)
vim.keymap.set("n", "<leader>sh", fzf.helptags)
vim.keymap.set("n", "<leader>sd", fzf.diagnostics_workspace)

-- LSP
vim.keymap.set("n", "<leader>ds", fzf.lsp_document_symbols)
vim.keymap.set("n", "<leader>ws", fzf.lsp_live_workspace_symbols)

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
