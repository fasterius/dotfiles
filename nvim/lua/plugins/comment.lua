-- Commenting code with Treesitter-support
return { 'numToStr/Comment.nvim',
    keys = {
        { 'gc' },
    },
    config = function()
        require('Comment').setup()
    end
}
