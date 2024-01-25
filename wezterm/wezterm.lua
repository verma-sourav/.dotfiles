local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
   config = wezterm.config_builder()
end

config.audible_bell = "Disabled"
config.color_scheme = "Catppuccin Mocha"
config.default_prog = { "fish", "-l" }
config.font = wezterm.font_with_fallback({ "Akoni Nerd Font", "Akoni NF" })
config.font_size = 12.0
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 100
config.initial_rows = 30
config.scrollback_lines = 10000
config.show_tab_index_in_tab_bar = true
config.window_close_confirmation = "NeverPrompt"

-- Disabling Wayland here causes Wezterm to run using XWayland
-- On Ubuntu w/ Wayland the terminal has a different-looking title bar and double clicking the
-- title bar doesn't maximize the window. Swapping this fixes those issues.
config.enable_wayland = false

config.mouse_bindings = {
   -- Change the default click behavior so that it only selects
   -- text and doesn't open hyperlinks
   {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = act.CompleteSelection("PrimarySelection"),
   },

   -- and make CTRL-Click open hyperlinks
   {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = act.OpenLinkAtMouseCursor,
   },

   -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
   {
      event = { Down = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = act.Nop,
   },
}

return config
