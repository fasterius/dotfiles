-- Location of the Zettelkasten, shared by `plugin/zettelkasten.lua` and the
-- Markdown / Markdown-Oxide language server configs
local M = {}

-- Resolve symlinks since buffer names use the real path
M.dir =
    vim.fs.normalize(vim.fn.resolve(vim.fs.normalize("~/docs/zettelkasten")))

---Function to check whether a buffer is a note inside the Zettelkasten
---@param bufnr integer
---@return boolean
function M.contains(bufnr)
    local name = vim.api.nvim_buf_get_name(bufnr)
    name = vim.fs.normalize(vim.fn.resolve(name))
    return vim.startswith(name, M.dir .. "/")
end

return M
