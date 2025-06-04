require("core.settings")
require("core.lazy").setup()
require("core.autocmds").setup()
require("core.keymaps")
require("core.commands").register_user_commands()

local machine_specific_config = vim.fn.glob("~/.config/dots/nvim/init.lua")
if machine_specific_config ~= "" then
    loadfile(machine_specific_config)()
end
