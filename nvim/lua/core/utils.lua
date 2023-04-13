-- Function to re-source core configs
-- Needed because a simple `:source $MYVIMRC` does not re-source any `require()`
-- statements contained therein (which will just use the cache from the initial
-- opening of the buffer); explicit use of `dofile()` ignores cache.
function SourceCoreConfigs()

    -- Find absolute path to the `lua/core/` directory
    local core_path = vim.fn.expand('$MYVIMRC'):match("(.*/)") .. 'lua/core/'

    -- Reload each relevant config module with `dofile()`
    local modules = { 'autocommands', 'keymaps', 'options', 'utils' }
    for _, module in ipairs(modules) do
        local filepath = core_path .. module .. '.lua'
        dofile(filepath)
    end
    print('Config reloaded')
end
vim.keymap.set('n', '<leader>v', SourceCoreConfigs)
