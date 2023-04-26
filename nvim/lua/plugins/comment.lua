-- Commenting code with Treesitter-support
return { 'fasterius/Comment.nvim',
    keys = {
        { 'gc', mode = { 'n', 'x'} },
    },
    config = function()
        require('Comment').setup()
    end
}
