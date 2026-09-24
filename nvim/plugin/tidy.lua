-- Removes trailing whitespace on save
-- Lazy loading on first buffer write
vim.api.nvim_create_autocmd("BufWritePre", {
    once = true,
    callback = function(args)
        vim.pack.add({
            "https://github.com/mcauley-penney/tidy.nvim",
        })
        require("tidy").setup()

        -- `setup()` registers tidy's own `BufWritePre` autocommand during the
        -- dispatch of this one, so it misses this write; run it directly
        vim.api.nvim_exec_autocmds(
            "BufWritePre",
            { group = "tidy", buffer = args.buf, modeline = false }
        )
    end,
})
