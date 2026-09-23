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
