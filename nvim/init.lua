require("autocommands")
require("keymaps")
require("load-plugins")
require("lsp")
require("options")
require("utils")

local is_ssh = os.getenv("SSH_TTY") ~= nil
if is_ssh then
    require("hpc")
end
