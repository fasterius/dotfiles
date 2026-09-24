return {
    cmd = { "marksman", "server" },
    filetypes = { "markdown", "quarto" },
    -- Markdown files inside the Zettelkasten dir is handled by markdown-oxide
    root_dir = function(bufnr, on_dir)
        if not require("zettelkasten").contains(bufnr) then
            on_dir(vim.fs.root(bufnr, { ".marksman.toml", ".git" }))
        end
    end,
}
