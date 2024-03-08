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

-- Replace word under cursor in quickfix list
function ReplaceInQuickfix()
    return ':cdo %s/' .. vim.fn.expand("<cword>") .. '//g<left><left>'
end
vim.keymap.set('n', 'gs', ReplaceInQuickfix, { expr = true })

-- Function to toggle "zoom" on a split
-- Works by opening a tab with the current split (toggle on) that can be closed
-- when zoom is no longer desired (toggle off). Keeps track of the view, centers
-- on the current line when zooming out and disables tabline when zoomed.
function ToggleZoom()
    -- Current split is not zoomed: zoom in
    if vim.t.zoom == nil then
        vim.cmd[[tab split]]
        vim.o.showtabline = false
        vim.t.zoom = 'zoom'
    -- Current split is zoomed: zoom out
    else
        if vim.t.zoom == 'zoom' then
            vim.cmd[[mkview]]
            vim.o.showtabline = true
            vim.cmd[[tab close]]
            vim.cmd[[loadview]]
            vim.cmd[[normal! zz]]
        end
    end
end
vim.keymap.set('n', '<localleader>z', ToggleZoom)
