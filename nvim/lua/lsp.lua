-- The LSP setup needs to load the completion plugin here, before `plugin/`
vim.pack.add({
    "https://github.com/hrsh7th/cmp-nvim-lsp",
})

-- LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend(
    "force",
    capabilities,
    require("cmp_nvim_lsp").default_capabilities()
)
capabilities = vim.tbl_deep_extend("force", capabilities, {
    textDocument = {
        completion = {
            completionItem = {
                snippetSupport = true,
            },
        },
    },
})

-- General LSP configuration (is overridden by specific LSP configs)
vim.lsp.config("*", {
    root_markers = { ".git" },
    capabilities = capabilities,
})

-- Disable built-in colourization
vim.lsp.document_color.enable(false)

-- Enable all language servers in `lsp/` directory
local lsp_configs = {}
for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
    local server_name = vim.fn.fnamemodify(f, ":t:r")
    table.insert(lsp_configs, server_name)
end
vim.lsp.enable(lsp_configs)

-- Change diagnostic icon to a circle instead of a square
vim.diagnostic.config({
    virtual_text = {
        prefix = "● ",
    },
})
