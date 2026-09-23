return {
    cmd = { "R", "--no-echo", "-e", "languageserver::run()" },
    filetypes = { "r", "rmd", "rmarkdown" },
    root_markers = { ".git" },
    -- Disable autoformatting and reset `formatexpr`, so it doesn't hijack
    -- internal `gq` formatting
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        vim.bo[bufnr].formatexpr = ""
    end,
}
