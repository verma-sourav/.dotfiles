local on_mac = require("util").on_mac
local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("bindings").apply_to_config(config)

config.audible_bell = "Disabled"
config.color_scheme = "Catppuccin Mocha"
config.default_prog = { "fish", "-l" }
config.font_size = on_mac and 14.0 or 12.0
config.font = wezterm.font_with_fallback({
   "Berkeley Mono Nerd Font",
   "Berkeley Mono NF",
   "Akoni Nerd Font",
   "Akoni NF",
})
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 100
config.initial_rows = 30
config.scrollback_lines = 10000
config.show_tab_index_in_tab_bar = true
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false
config.use_fancy_tab_bar = false
config.tab_max_width = 32

config.colors = {
   tab_bar = {
      background = "rgba(0,0,0,0)",
      new_tab = {
         bg_color = "#1e1e2e",
         fg_color = "#bfc8e5",
      },
   },
}

-- Disabling Wayland here causes Wezterm to run using XWayland
-- On Ubuntu w/ Wayland the terminal has a different-looking title bar and double clicking the
-- title bar doesn't maximize the window. Swapping this fixes those issues.
config.enable_wayland = false

return config
