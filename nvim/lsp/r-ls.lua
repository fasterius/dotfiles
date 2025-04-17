return {
    cmd = { "R", "--no-echo", "-e", "languageserver::run()" },
    filetypes = { "r", "rmd", "rmarkdown" },
    root_markers = { ".git" },
}
