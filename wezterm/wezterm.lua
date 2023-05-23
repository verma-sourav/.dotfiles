local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.audible_bell = 'Disabled'
config.color_scheme = 'Catppuccin Mocha'
config.default_prog = { 'fish', '-l' }
config.font = wezterm.font_with_fallback({'Akoni Nerd Font', 'Akoni NF'})
config.font_size = 12.0
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 100
config.initial_rows = 30
config.scrollback_lines = 10000
config.show_tab_index_in_tab_bar = true
config.window_close_confirmation = 'NeverPrompt'

return config

