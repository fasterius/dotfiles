-- Highlight colour codes with the actual colours
-- vim.pack.add({ "https://github.com/NvChad/nvim-colorizer.lua" })

-- cmd = {
-- "ColorizerAttachToBuffer",
-- "ColorizerToggle",
-- },

local function lazy_load(command, callback)
    vim.api.nvim_create_user_command(command, function(opts)
        vim.api.nvim_del_user_command(command)
        callback()
        vim.cmd({ cmd = command, args = opts.fargs, bang = opts.bang })
    end, {
        desc = "Single use passthrough of user command with callback before main command call",
        nargs = "*",
        bang = true,
    })
end

lazy_load("ColorizerToggle", function()
    vim.pack.add({ "https://github.com/NvChad/nvim-colorizer.lua" })

    require("colorizer").setup({
        -- Don't colour e.g. `red` or `blue`
        user_default_options = {
            names = false,
        },
    })
end)
