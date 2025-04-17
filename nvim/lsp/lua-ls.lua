return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".git",
    },
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            runtime = { version = "LuaJIT" },
            workspace = {
                library = vim.env.VIMRUNTIME, -- Include Neovim's API
                checkThirdParty = false,
            },
        },
    },
}
