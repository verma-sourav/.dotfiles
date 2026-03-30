local M = {}
local utils = require("core.utils")

--- @class RipgrepFiletype
--- @field name string The name of the file type as reported by ripgrep
--- @field detailed string The detailed info for the filetype with the name and possible extensions

--- Returns a list of available file types from the local instance of ripgrep. If ripgrep is not
--- available, or there is an issue running ripgrep, a nil table will be returned.
--- @return RipgrepFiletype[] | nil
local function get_ripgrep_filetypes()
    local status = vim.system({ "rg", "--type-list" }, { text = true }):wait()
    if status.code ~= 0 then
        utils.error("Failed to execute ripgrep (rg) to grab type list")
        return nil
    end

    --- @class RipgrepFiletype
    local filetypes = {}
    for line in status.stdout:gmatch("[^\n]+") do
        local filetype = line:match("^(%w+):")
        if filetype then
            table.insert(filetypes, {
                name = filetype,
                detailed = line,
            })
        end
    end
    return filetypes
end

--- Prompts the user for a specific ripgrep filetype and then runs the grep picker with that
--- filetype. This allows searching for text in a specific file type such as a shell script.
--- @return nil
function M.grep_filetype()
    local rg_filetypes = get_ripgrep_filetypes()
    if rg_filetypes == nil or #rg_filetypes == 0 then
        return
    end

    local items = {}
    for i, ft in ipairs(rg_filetypes) do
        table.insert(items, {
            idx = i,
            score = i,
            text = ft.detailed,
            filetype = ft.name,
        })
    end

    Snacks.picker({
        items = items,
        layout = { preset = "select" },
        format = function(item)
            return { { item.text, "SnacksPickerLabel" } }
        end,
        confirm = function(picker, item)
            picker:close()
            Snacks.picker.grep({ ft = item.filetype })
        end,
    })
end

return M
