-- Commenting code with Treesitter-support
return { 'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}
