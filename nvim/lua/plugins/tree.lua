-- Traditional, tree-based file browsing
return {
    'nvim-tree/nvim-tree.lua',
    keys = {
        { '<leader>t', ':NvimTreeToggle <CR>', { desc = 'Toggle file tree browser' } }
    },
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('nvim-tree').setup {

            -- Close browser after opening a file
            actions = {
                open_file = {
                    quit_on_open = true
                }
            }
        }
    end
}
