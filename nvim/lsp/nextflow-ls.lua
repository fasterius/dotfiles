return {
    cmd = {
        "java",
        "-jar",
        vim.fn.expand("$HOME/opt/nextflow-language-server/build/libs/language-server-all.jar"),
    },
    filetypes = { "nextflow" },
    root_markers = { "nextflow.config", ".git" },
    settings = {
        nextflow = {
            files = { exclude = { ".git", ".nf-test", "work" } },
            suppressFutureWarnings = false,
            formatting = { harshilAlignment = true },
        },
    },
}
