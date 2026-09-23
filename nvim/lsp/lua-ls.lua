return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".luarc.json",
        ".luarc.jsonc",
        ".git",
    },
    -- Reset `formatexpr` so that it doesn't get hijacked from `lua-ls`'s
    -- range-formatting support
    on_attach = function(_, bufnr)
        vim.bo[bufnr].formatexpr = ""
    end,
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
