return {
    cmd = { "markdown-oxide" },
    filetypes = { "markdown" },
    -- Only attach to notes inside the Zettelkasten
    root_dir = function(bufnr, on_dir)
        local zettelkasten = require("zettelkasten")
        if zettelkasten.contains(bufnr) then
            on_dir(zettelkasten.dir)
        end
    end,
    -- Needed for e.g. the "create file for unresolved link" code action
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
}
