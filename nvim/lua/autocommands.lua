-- Set formatoptions globally (overrides filetype-specific settings)
--   Auto-wrap comments using 'textwidth' (c)
--   Allow `gq`-formatting of comments (q)
--   Auto-wrap text using 'textwidth' (t)
--   Remove comment leader when joining lines (j)
--   Auto-wrap lists to follow list element indentation (n)
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "*",
    command = ":set formatoptions=cjqtn",
})

-- Conceal when in `telekasten` filetype
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "telekasten",
    callback = function()
        vim.o.conceallevel = 2
        vim.o.concealcursor = "nc"
    end,
})

-- Open Telescope's `find_files` or `git_files` when Neovim is called
-- without a specific file to open
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if next(vim.fn.argv()) == nil then
            vim.schedule(function()
                local telescope = require("telescope.builtin")
                if os.execute("git rev-parse --is-inside-work-tree >> /dev/null 2>&1") == 0 then
                    telescope.git_files()
                else
                    telescope.find_files()
                end
            end)
        end
    end,
})
