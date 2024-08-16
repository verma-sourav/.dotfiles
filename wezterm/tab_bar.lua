local on_mac = require("util").on_mac
local wezterm = require("wezterm")
local M = {}

-- This function returns the suggested title for a tab. It prefers the title that was set via
-- `tab:set_title()`or `wezterm cli set-tab-title`, but falls back to the title of the active
-- pane in that tab.
local function tab_title(tab_info)
   local title = tab_info.tab_title
   if title and #title > 0 then
      return title
   end
   return tab_info.active_pane.title
end

-- https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
local function format_tab_title(tab, _, _, _, _, _)
   local title = tab_title(tab)
   if tab.is_active then
      return {
         { Background = { Color = "#181825" } },
         { Foreground = { Color = "#eba0ac" } },
         { Text = " " .. title .. " " },
      }
   else
      return {
         { Background = { Color = "#1e1e2e" } },
         { Text = " " .. title .. " " },
      }
   end
end

function M.apply_to_config(config)
   wezterm.on("format-tab-title", format_tab_title)
   config.use_fancy_tab_bar = true
   config.window_frame = {
      font_size = on_mac and 12.0 or 10.0,
      font = config.font,
      active_titlebar_bg = "#1e1e2e",
      inactive_titlebar_bg = "#1e1e2e",
   }
end

return M
