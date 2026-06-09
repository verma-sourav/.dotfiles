vim.pack.add({
    "https://github.com/folke/snacks.nvim",
})

local layout_horizontal = "custom_horizontal"
local layout_vertical = "custom_vertical"

local state = {
    preview = false,
    maximized = false,
    layout = {
        overridden = false,
        preset = "",
    },
}

--- Used as the `config` option for custom layouts. This updates the layout so that it continues to
--- have settings that have already been changed in this setting. If the picker has been maximized
--- using <a-m>, this will continue opening pickers in fullscreen until it is undone.
--- @param layout snacks.picker.layout.Config
--- @return snacks.picker.layout.Config
local function configure_picker(layout)
    layout.fullscreen = state.maximized
    layout.hidden = state.preview and {} or { "preview" }
    return layout
end

require("snacks").setup({
    bigfile = { enabled = true },
    git = { enabled = true },
    indent = {
        enabled = true,
        -- https://github.com/folke/snacks.nvim/discussions/332
        indent = { enabled = false },
    },
    input = { enabled = true },
    statuscolumn = { enabled = true },
    picker = {
        enabled = true,
        matcher = {
            cwd_bonus = true,
            frecency = true,
        },
        icons = {
            files = { enabled = false },
        },
        layout = {
            preset = function()
                if state.layout.overridden then
                    return state.layout.preset
                end
                state.layout.preset = vim.o.columns >= 120 and layout_horizontal or layout_vertical
                return state.layout.preset
            end,
        },
        layouts = {
            [layout_horizontal] = {
                config = configure_picker,
                layout = {
                    box = "horizontal",
                    width = 0.8,
                    height = 0.8,
                    min_width = 120,
                    {
                        box = "vertical",
                        border = true,
                        title = "{title} {live} {flags}",
                        { win = "input", height = 1, border = "bottom" },
                        { win = "list", border = "none" },
                    },
                    { win = "preview", border = true, width = 0.5, title = "{preview}" },
                },
            },
            [layout_vertical] = {
                config = configure_picker,
                layout = {
                    width = 0.8,
                    height = 0.8,
                    min_width = 80,
                    min_height = 20,
                    box = "vertical",
                    border = true,
                    title = "{title} {live} {flags}",
                    title_pos = "center",
                    { win = "input", height = 1, border = "bottom" },
                    { win = "list", border = "none" },
                    { win = "preview", height = 0.4, border = "top", title = "{preview}" },
                },
            },
        },
        actions = {
            -- Overriding existing Snacks.picker actions to also update the saved picker state.
            -- This allows the existing keymaps (<a-p> and <a-m>) to continue to work as normal.
            toggle_preview = function(picker)
                state.preview = not state.preview
                picker:toggle("preview", { enable = state.preview })
            end,
            toggle_maximize = function(picker)
                state.maximized = not state.maximized
                picker.layout:maximize()
            end,
            -- These actions are custom.
            cycle_layout = function(picker)
                state.layout.overridden = true
                if state.layout.preset == layout_horizontal then
                    state.layout.preset = layout_vertical
                    picker:set_layout(state.layout.preset)
                else
                    state.layout.preset = layout_horizontal
                    picker:set_layout(state.layout.preset)
                end
            end,
        },
        win = { input = { keys = {
            ["<a-c>"] = { "cycle_layout", mode = { "i", "n" } },
        } } },
    },
})
