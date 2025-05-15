-- Function to re-source core configs
-- Needed because a simple `:source $MYVIMRC` does not re-source any `require()`
-- statements contained therein (which will just use the cache from the initial
-- opening of the buffer); explicit use of `dofile()` ignores cache.
function SourceCoreConfigs()
    -- Find absolute path to the `lua/` directory
    local core_path = vim.fn.expand("$MYVIMRC"):match("(.*/)") .. "lua/"

    -- Reload each relevant config module with `dofile()`
    local modules = { "autocommands", "keymaps", "lsp", "options", "utils" }
    for _, module in ipairs(modules) do
        local filepath = core_path .. module .. ".lua"
        dofile(filepath)
    end
    print("Config reloaded")
end
vim.keymap.set("n", "<leader>v", SourceCoreConfigs)

-- Replace word under cursor in quickfix list
function ReplaceInQuickfix()
    return ":cdo s/" .. vim.fn.expand("<cword>") .. "//g<left><left>"
end
vim.keymap.set("n", "gs", ReplaceInQuickfix, { expr = true })
