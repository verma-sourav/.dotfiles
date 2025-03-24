local show_detailed_columns = false
local undetailed_columns = { "icon" }
local detailed_columns = { "icon", "permissions", "size" }

local M = {
    "stevearc/oil.nvim",
    lazy = false,
}

function M.config()
    require("oil").setup({
        delete_to_trash = true,
        columns = undetailed_columns,
        lsp_file_methods = {
            autosave_changes = true,
        },
        view_options = {
            is_hidden_file = function(name, _)
                return vim.startswith(name, ".") or vim.endswith(name, ".o") or name == "node_modules"
            end,
        },
        keymaps = {
            ["q"] = "actions.close",
            ["gd"] = {
                desc = "Toggle file detail view",
                callback = function()
                    show_detailed_columns = not show_detailed_columns
                    if show_detailed_columns then
                        require("oil").set_columns(detailed_columns)
                    else
                        require("oil").set_columns(undetailed_columns)
                    end
                end,
            },
        },
    })

    -- This helps the statusline to *actually* show relative paths. Without it, they end up always
    -- being absolute because oil always opens them using their absolute path.
    -- ref: https://github.com/stevearc/oil.nvim/issues/234#issuecomment-1879033555
    vim.api.nvim_create_augroup("OilRelPathFix", {})
    vim.api.nvim_create_autocmd("BufLeave", {
        group = "OilRelPathFix",
        pattern = "oil:///*",
        callback = function()
            vim.cmd("cd .")
        end,
    })
end

return M
