vim.pack.add({
    "https://github.com/nvim-mini/mini.nvim",
})

require("mini.bracketed").setup()
require("mini.bufremove").setup()
require("mini.comment").setup()
require("mini.diff").setup()
require("mini.git").setup()
require("mini.jump").setup()
require("mini.move").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup()

require("mini.trailspace").setup()
-- Setup the color for the highlighted trailing whitespace
vim.api.nvim_set_hl(0, "MiniTrailspace", { bg = "#f38ba8" })
-- Automatically trim newlines on save
local trailspace_group = require("utils").autocmd_group("trailspace")
vim.api.nvim_create_autocmd("BufWritePre", {
    group = trailspace_group,
    desc = "Trim trailing newlines on save",
    pattern = "*",
    command = "silent! lua MiniTrailspace.trim_last_lines()",
})

local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        -- Built-in completion
        { mode = "i", keys = "<C-x>" },
        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
        -- Window commands
        { mode = "n", keys = "<C-w>" },
        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },

    window = {
        delay = 750,
        config = { width = "auto" },
    },

    clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
        { mode = "n", keys = "<Leader>f", desc = "+Find" },
        { mode = "n", keys = "<Leader>g", desc = "+Git" },
        { mode = "n", keys = "<Leader>x", desc = "+Diagnostics" },
        { mode = "n", keys = "<Leader>c", desc = "+Code/LSP" },
        { mode = "n", keys = "<Leader>cg", desc = "+Goto" },
        { mode = "n", keys = "<Leader>cs", desc = "+Show" },
    },
})

local statusline = { mini = require("mini.statusline") }
statusline.mini.setup({
    set_vim_settings = false,
    content = {
        active = function()
            local mini = statusline.mini
            local mode, mode_hl = mini.section_mode({ trunc_width = 120 })
            local git = mini.section_git({ trunc_width = 40 })
            local diagnostics = mini.section_diagnostics({ trunc_width = 75 })
            local filename = statusline.section_filename()
            local fileinfo = statusline.section_fileinfo()
            local location = statusline.section_location()

            return mini.combine_groups({
                { hl = mode_hl, strings = { string.upper(mode) } },
                { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
                "%<", -- Mark general truncate point
                { hl = "MiniStatuslineFilename", strings = { filename } },
                "%=", -- End left alignment
                { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
                { hl = mode_hl, strings = { location } },
            })
        end,
    },
})

-- In the Git summary, just use the branch name and not the rest. This summary is used in the
-- Git section of the statusline.
vim.api.nvim_create_autocmd("User", {
    pattern = "MiniGitUpdated",
    callback = function(data)
        local summary = vim.b[data.buf].minigit_summary
        vim.b[data.buf].minigit_summary_string = summary.head_name or ""
    end,
})

-- Based on the original mini section, but always use the relative file name for normal files.
-- I'm in deeply-nested directories way too often for the absolute path to be useful.
-- https://github.com/echasnovski/mini.statusline/blob/6a22a137926c60f987ab76433c56230ffdd7c42d/lua/mini/statusline.lua#L383-L395
function statusline.section_filename()
    -- In terminal always use plain name
    if vim.bo.buftype == "terminal" then
        return "%t"
    end
    -- File name with 'truncate', 'modified', 'readonly' flags
    return "%f%m%r"
end

-- https://github.com/echasnovski/mini.statusline/blob/94d5e48415bdf872536e5812475fcf19e09f5c0e/lua/mini/statusline.lua#L401
function statusline.section_fileinfo()
    local utils = require("utils")
    local filetype = vim.bo.filetype

    -- Don't show anything if no filetype or not inside a "normal buffer"
    if filetype == "" or vim.bo.buftype ~= "" then
        return ""
    end

    local indent_info = " T"
    if utils.get_option("expandtab") then
        indent_info = " S" .. tostring(utils.get_option("tabstop"))
    end

    return filetype .. indent_info
end

function statusline.section_location()
    return "L%l C%v"
end
