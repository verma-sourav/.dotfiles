local config = {
    bigfile = { enabled = true },
    git = { enabled = true },
    indent = {
        enabled = true,
        -- https://github.com/folke/snacks.nvim/discussions/332
        indent = { enabled = false },
    },
    input = { enabled = true },
    picker = {
        enabled = true,
        layouts = {
            fullscreen = {
                fullscreen = true,
                layout = {
                    backdrop = false,
                    box = "vertical",
                    border = "rounded",
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                    { win = "input", height = 1, border = "bottom" },
                    { win = "list", border = "none" },
                    { win = "preview", title = "{preview}", height = 0.5, border = "top" },
                },
            },
        },
        layout = function(source)
            if vim.endswith(source, "files") then
                return "fullscreen"
            end
            if source == "grep" then
                return "fullscreen"
            end
            return vim.o.columns >= 120 and "default" or "vertical"
        end,
    },
    statuscolumn = { enabled = true },
}

local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
        require("snacks").setup(config)

        -- https://github.com/folke/snacks.nvim/issues/1400
        -- https://github.com/folke/snacks.nvim/blob/bc0630e43be5699bb94dadc302c0d21615421d93/lua/snacks/picker/util/init.lua#L20
        Snacks.picker.util.truncpath = function(path, len, opts)
            -- This section is from this existing truncpath implementation
            local cwd = svim.fs.normalize(opts and opts.cwd or vim.fn.getcwd(), { _fast = true, expand_env = false })
            local home = svim.fs.normalize("~")
            path = svim.fs.normalize(path, { _fast = true, expand_env = false })

            if path:find(cwd .. "/", 1, true) == 1 and #path > #cwd then
                path = path:sub(#cwd + 2)
            else
                local root = Snacks.git.get_root(path)
                if root and root ~= "" and path:find(root, 1, true) == 1 then
                    local tail = vim.fn.fnamemodify(root, ":t")
                    path = "⋮" .. tail .. "/" .. path:sub(#root + 2)
                elseif path:find(home, 1, true) == 1 then
                    path = "~" .. path:sub(#home + 1)
                end
            end
            path = path:gsub("/$", "")

            -- This seciton is based on the 'align' option from this snacks.nvim PR
            -- https://github.com/folke/snacks.nvim/pull/743
            local picker = Snacks.picker.get()
            if #picker > 0 then
                len = vim.api.nvim_win_get_width(picker[1].list.win.win) - 5
            end

            local tw = vim.api.nvim_strwidth(path)
            if tw > len then
                return "…" .. vim.fn.strcharpart(path, tw - len + 1, len - 1)
            end
            return path
        end
    end,
}

-- Cache the result of `git rev-parse`
local is_inside_work_tree = {}

-- Show git files when in a repository, otherwise just show all files.
-- Ideally this should be moved to a custom picker, but I haven't figured out how to do that yet.
function M.project_files()
    local cwd = vim.fn.getcwd()
    if is_inside_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is-inside-work-tree")
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
        Snacks.picker.git_files({ untracked = true })
    else
        Snacks.picker.files()
    end
end

return M
