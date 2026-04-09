-- Enable the fast loading experimental feature
vim.loader.enable()

require("autocommands")
require("keymaps")
require("lsp")
require("options")
require("utils")

local is_ssh = os.getenv("SSH_TTY") ~= nil
if is_ssh then
    require("hpc")
end
