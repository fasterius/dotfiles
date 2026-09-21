-- Add number of matches and other information to searches
return {
    "kevinhwang91/nvim-hlslens",
    keys = {
        "/",
        "?",
        "n",
        "N",
        "*",
        "#",
        "g*",
        "g#",
    },
    config = function()
        require("hlslens").setup({
            calm_down = true, -- Clear highlighting when searching is done
        })

        local kopts = { noremap = true, silent = true }
        vim.api.nvim_set_keymap(
            "n",
            "n",
            [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zzzv]],
            kopts
        )
        vim.api.nvim_set_keymap(
            "n",
            "N",
            [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zzzv]],
            kopts
        )
        vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>zzzv]], kopts)
        vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>zzzv]], kopts)
        vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>zzzv]], kopts)
        vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>zzzv]], kopts)

        vim.api.nvim_set_hl(0, "HlSearchLens", { link = "StatusLine" })
        vim.api.nvim_set_hl(0, "HlSearchNear", { link = "IncSearch" })
        vim.api.nvim_set_hl(0, "HlSearchLensNear", { link = "IncSearch" })
    end,
}
