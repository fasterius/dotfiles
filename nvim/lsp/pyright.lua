return {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
        ".git",
    },
    -- Use the first Python in PATH when the server starts (e.g. a Pixi
    -- project's), as Pyright otherwise uses the one in its own environment
    before_init = function(_, config)
        local python = vim.fn.exepath("python")
        if python ~= "" then
            config.settings.python.pythonPath = python
        end
    end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "off",
            },
        },
    },
}
