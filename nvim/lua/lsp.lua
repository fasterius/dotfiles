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

-- Autocommand for LSP attachment
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", {}),
    callback = function(args)
        -- Get LSP name (same as filename in `lsp/` directory)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Disable autoformatting for Nextflow and R
        if vim.tbl_contains({ "nextflow-ls", "r-ls" }, client.name) then
            client.server_capabilities.documentFormattingProvider = false
            vim.bo[args.buf].formatexpr = ""
        end

        -- Reset `formatexpr` for Lua to be able to use `gq`
        if vim.tbl_contains({ "lua-ls" }, client.name) then
            vim.bo[args.buf].formatexpr = ""
        end

        -- Disable semantic tokens for Nextflow
        if client.name == "nextflow-ls" then
            client.server_capabilities.semanticTokensProvider = false
        end
    end,
})

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
