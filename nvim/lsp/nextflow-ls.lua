return {
    cmd = {
        "java",
        "-jar",
        vim.fn.expand("$HOME/opt/nextflow-language-server-all.jar"),
    },
    filetypes = { "nextflow" },
    root_markers = { "nextflow.config", ".git" },
    settings = {
        nextflow = {
            files = { exclude = { ".git", ".nf-test", "work" } },
            suppressFutureWarnings = false,
            errorReportingMode = "paranoid",
            formatting = { harshilAlignment = true },
        },
    },
}
