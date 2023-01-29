-- Commenting code with Treesitter-support
return { 'numToStr/Comment.nvim',
    keys = {
        { 'gc', mode = { 'n', 'x'} },
    },
    config = function()
        require('Comment').setup()
    end
}
