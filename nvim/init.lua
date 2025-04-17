require("core")
require("load-plugins")

-- LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities = vim.tbl_deep_extend("force", capabilities, {
    textDocument = {
        completion = {
            completionItem = {
                snippetSupport = true,
            },
        },
    },
})

-- Common LSP configuration
vim.lsp.config("*", {
    root_markers = { ".git" },
    capabilities = capabilities,
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

-- Autocommand for LSP attachment
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", {}),
    callback = function(args)
        -- Get LSP name (same as filename in `lsp/` directory)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Disable autoformatting for Nextflow and R
        if client.name == "nextflow-ls" or client.name == "r-ls" then
            client.server_capabilities.documentFormattingProvider = false
        end
    end,
})
