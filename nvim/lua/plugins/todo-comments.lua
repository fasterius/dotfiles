-- Working with and highlighting TODO comments
return {
    'folke/todo-comments.nvim',
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()

        local todo = require('todo-comments')
        todo.setup()

        -- Keymaps to jump between TODO comments
        vim.keymap.set("n", "]t", function() todo.jump_next() end, { desc = "Next TODO comment" })
        vim.keymap.set("n", "[t", function() todo.jump_prev() end, { desc = "Previous TODO comment" })

    end
}
