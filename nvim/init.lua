require("config.settings")
require("config.autocmds")
require("config.keymaps")
require("config.commands")

local utils = require("utils")

-- Instead of a single global shada file, use a per-project shada file. This will keep marks,
-- oldfiles, and more contrained to the project they are from.
local dir = utils.project_dir()
local dirfile = vim.fn.substitute(dir, "/", "-", "g") .. ".shada"
vim.o.shadafile = vim.fs.joinpath(vim.fn.stdpath("state"), "shada", dirfile)

-- If a machine-specific config exists (in this case the pre-plugin one since the plugin dir hasn't
-- been loaded yet), then we can go ahead and load that now.
if vim.uv.fs_stat(utils.machine_config.pre_plugin_file) then
    loadfile(utils.machine_config.pre_plugin_file)()
end
