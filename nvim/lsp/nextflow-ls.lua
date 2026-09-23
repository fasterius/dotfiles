return {
    cmd = {
        "java",
        "-jar",
        vim.fn.expand("$HOME/opt/nextflow-language-server-all.jar"),
    },
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
