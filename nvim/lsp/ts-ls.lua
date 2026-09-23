return {
    init_options = { hostInfo = "neovim" },
    cmd = { "typescript-language-server", "--stdio" },
    -- Reset `formatexpr`, so that it doesn't hijack internal `gq` commands
    on_attach = function(_, bufnr)
        vim.bo[bufnr].formatexpr = ""
    end,
    filetypes = {
        "javascript",
        "typescript",
        "ojs",
    },
    root_markers = {
        "tsconfig.json",
        "jsconfig.json",
        "package.json",
        ".git",
    },
}
