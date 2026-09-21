-- Removes trailing whitespace on save
return {
    "mcauley-penney/tidy.nvim",
    event = "BufWritePre",
    config = true,
}
