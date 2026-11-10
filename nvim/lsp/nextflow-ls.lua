return {
    cmd = { "nextflow-lsp" },
    filetypes = { "nextflow" },
    root_markers = { "nextflow.config", ".git" },
    -- Disable autoformatting and semantic tokens
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.semanticTokensProvider = false
    end,
    settings = {
        nextflow = {
            files = { exclude = { ".git", ".nf-test", "work" } },
            suppressFutureWarnings = false,
            errorReportingMode = "paranoid",
            formatting = { harshilAlignment = true },
        },
    },
}
